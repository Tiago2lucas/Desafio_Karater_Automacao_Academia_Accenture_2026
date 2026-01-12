Feature: Configuração de Autenticação

  Scenario: Criar usuário e gerar token
    * def Generator = Java.type('utils.DateGenerator')
    * def info = { userName: '#(Generator.gerarNomeUsuarioValido())', password: '#(Generator.gerarSenhaUsuarioValida())' }

    # Cria o usuário para os testes de livros
    Given url urlBaseUser
    And path 'User'
    And request info
    When method post
    Then status 201
    * def id = response.userID

    # Gera o token de acesso
    Given path 'GenerateToken'
    And request info
    When method post
    Then status 200
    * def auth = 'Bearer ' + response.token

    #  Busca o catálogo de Livros
    Given url urlBaseBook
    And path 'Books'
    When method get
    Then status 200

    * def isbnAleatorio = Generator.getIsbnAleatorio(response.books)
