Feature: Gerenciamento de Ciclo de Vida do Usuário

  Background:
    * url urlBase
    * def Generator = Java.type('utils.DateGenerator')
    * def payload = read('DadosTesteUsuario/cadastrar-usuário-dado-validos.json')
    * set payload.userName = Generator.gerarNomeUsuarioValido()
    * set payload.password = Generator.gerarSenhaUsuarioValida()

  @FluxoCompletoPositivo
  Scenario: Cadastro, Autenticação, Consulta e Exclusão com Sucesso

    # Realiza o cadastro de um novo usuário no sistema
    Given path 'Account', 'v1', 'User'
    And request payload
    When method post
    Then status 201
    * def idUsuario = response.userID
    * print 'Usuário criado com sucesso. ID:', idUsuario

    # Gera o token de acesso necessário para as próximas operações
    Given path 'Account', 'v1', 'GenerateToken'
    And request { userName: '#(payload.userName)', password: '#(payload.password)' }
    When method post
    Then status 200
    * def token = 'Bearer ' + response.token
    * print 'Token de acesso gerado com sucesso:', response.token

    # Confirma se as credenciais do usuário estão autorizadas
    Given path 'Account', 'v1', 'Authorized'
    And header Authorization = token
    And request { userName: '#(payload.userName)', password: '#(payload.password)' }
    When method post
    Then status 200
    And match response == 'true'
    * print 'Status de autorização confirmado:', response

    # Busca as informações detalhadas do perfil utilizando o ID e Token
    Given path 'Account', 'v1', 'User', idUsuario
    And header Authorization = token
    And header Accept = 'application/json'
    When method get
    Then status 200
    And match response.userId == idUsuario
    And match response.username == payload.userName
    * print 'Dados do perfil recuperados:', response

    # Remove o usuário para garantir a limpeza dos dados de teste
    Given path 'Account', 'v1', 'User', idUsuario
    And header Authorization = token
    And header Accept = 'application/json'
    When method delete
    Then status 204
    * print 'Usuário removido e ciclo finalizado.'