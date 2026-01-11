Feature: Testes de Negativo e Exceção no Ciclo de Vida do Usuário

  Background:
    * url urlBase
    * def Generator = Java.type('utils.DateGenerator')
    * def nomeInexistente = Generator.gerarNomeUsuarioValido()
    * def senhaInvalida = Generator.geraSenhaUsuarioInvalida()

  @FluxoCompletoNegativo
  Scenario: Fluxo de Falha: Tentativas de Cadastro, Token e Acesso Inválidos

    # Tentativa de cadastro com senha fora dos padrões
    Given path 'Account', 'v1', 'User'
    And request { userName: '#(nomeInexistente)', password: '#(senhaInvalida)' }
    When method post
    Then status 400
    And match response == { code: '#string', message: '#string' }
    * print 'Falha no cadastro confirmada:', response

    # Tentativa de gerar token enviando apenas o nome do usuário
    Given path 'Account', 'v1', 'GenerateToken'
    And request { userName: '#(nomeInexistente)' }
    When method post
    Then status 400
    And match response == { code: '#string', message: '#string' }
    * print 'Falha na geração de token confirmada:', response

    # Tentativa de autorização sem informar a senha
    Given path 'Account', 'v1', 'Authorized'
    And request { userName: '#(nomeInexistente)' }
    When method post
    Then status 400
    And match response == { code: '#string', message: '#string' }
    * print 'Falha na autorização confirmada:', response

    # Tentativa de buscar um usuário sem fornecer token de autorização
    Given path 'Account', 'v1', 'User', 'id-inexistente'
    When method get
    Then status 401
    And match response == { code: '#string', message: '#string' }
    * print 'Acesso negado confirmado para busca sem token:', response