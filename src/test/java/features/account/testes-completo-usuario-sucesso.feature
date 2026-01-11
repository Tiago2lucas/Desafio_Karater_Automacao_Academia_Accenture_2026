Feature: Gerenciamento de Ciclo de Vida do Usuário

  Background:
    * url urlBaseUser

    * def dados = callonce read('classpath:features/usuario/DadosTesteUsuario/usuario-config.feature')
    * def idUsuario = dados.id
    * def token = dados.auth
    * def nomeUsuario = dados.nome
    * def cabecalho = { Authorization: '#(dados.auth)', Accept: 'application/json' }

  @FluxoCompletoAccountPositivo
  Scenario: Validação de Autorização, Consulta de Perfil e Exclusão

    # Confirma se as credenciais geradas no setup estão autorizadas (Post)
    Given path '/Authorized'
    And header Authorization = token
    And request { userName: '#(nomeUsuario)', password: '#(dados.payloadGeral.password)' }
    When method post
    Then status 200
    And match response == 'true'
    * print 'Status de autorização confirmado para:', nomeUsuario

    # Busca as informações detalhadas do perfil utilizando o ID e Token do setup (Get)
    Given path '/User', idUsuario
    And headers cabecalho
    When method get
    Then status 200
    And match response.userId == idUsuario
    And match response.username == nomeUsuario
    * print 'Dados do perfil recuperados com sucesso para o ID:', idUsuario

    # Remove o usuário para garantir a limpeza do ambiente (Delete)
    Given path '/User', idUsuario
    And headers cabecalho
    When method delete
    Then status 204
    * print 'Usuário removido. Ciclo de vida encerrado com sucesso.'