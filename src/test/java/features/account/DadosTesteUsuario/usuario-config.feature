Feature: Setup de Autenticação de Usuário

  Scenario: Criar usuário e gerar token de acesso
    * def Generator = Java.type('utils.DateGenerator')
    * def payloadGeral = read('classpath:features/usuario/DadosTesteUsuario/cadastrar-usuário-dado-validos.json')
    * set payloadGeral.userName = Generator.gerarNomeUsuarioValido()
    * set payloadGeral.password = Generator.gerarSenhaUsuarioValida()

    # Criação do usuário
    Given url urlBaseUser
    And path  '/User'
    And request payloadGeral
    When method post
    Then status 201
    * def id = response.userID

    # Geração do token
    Given path '/GenerateToken'
    And request { userName: '#(payloadGeral.userName)', password: '#(payloadGeral.password)' }
    When method post
    Then status 200

    # Exportação das variáveis para os outros arquivos
    * def auth = 'Bearer ' + response.token
    * def credenciais = payloadGeral
    * def nome = payloadGeral.userName
    * def senha = payloadGeral.password