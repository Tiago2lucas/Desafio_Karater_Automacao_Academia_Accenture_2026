Feature: Configuração de Autenticação

  Scenario: Criar usuário e gerar token
    * def Generator = Java.type('utils.DateGenerator')
    * def info = { userName: '#(Generator.gerarNomeUsuarioValido())', password: '#(Generator.gerarSenhaUsuarioValida())' }

    # Cria o usuário para os testes de livros
    Given url urlBase
    And path 'Account', 'v1', 'User'
    And request info
    When method post
    Then status 201
    * def id = response.userID

    # Gera o token de acesso
    Given path 'Account', 'v1', 'GenerateToken'
    And request info
    When method post
    Then status 200
    * def auth = 'Bearer ' + response.token