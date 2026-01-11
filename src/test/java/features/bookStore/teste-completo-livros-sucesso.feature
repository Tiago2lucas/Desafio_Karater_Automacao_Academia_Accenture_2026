Feature: Gerenciamento do Acervo da Livraria

  Background:
    * url urlBaseBook
    * def setupUsuario = callonce read('classpath:features/books/DadosTesteLivros/usuario-livro-config.feature')
    * def token = setupUsuario.auth
    * def userId = setupUsuario.id

  @FluxoCompletoBookStorePositivo
  Scenario: Ciclo de vida dos livros: Listar, Adicionar, Atualizar e Remover

    # Lista o catálogo para identificar os livros disponíveis (Get)
    Given path '/Books'
    When method get
    Then status 200
    * def isbnOriginal = response.books[0].isbn
    * def isbnNovo = response.books[1].isbn
    * print 'Livros selecionados para o teste:', isbnOriginal, 'e', isbnNovo

    # Adiciona o livro à coleção do usuário (Put)
    Given path '/Books'
    And header Authorization = token
    And request { userId: '#(userId)', collectionOfIsbns: [{ isbn: '#(isbnOriginal)' }] }
    When method post
    Then status 201
    * print 'Livro adicionado com sucesso!'

    # Consulta os detalhes do livro na coleção (Get)
    Given path '/Book'
    And param ISBN = isbnOriginal
    When method get
    Then status 200
    And match response.isbn == isbnOriginal
    * print 'Consulta de detalhes do livro realizada.'

    # Substitui o livro na coleção (Update)
    Given path '/Books', isbnOriginal
    And header Authorization = token
    And request { userId: '#(userId)', isbn: '#(isbnNovo)' }
    When method put
    Then status 200
    * print 'Livro atualizado na coleção com sucesso.'

    # Remove o livro específico (Delete)
    Given path '/Book'
    And header Authorization = token
    And request { userId: '#(userId)', isbn: '#(isbnNovo)' }
    When method delete
    Then status 204
    * print 'Livro removido individualmente.'

    # Esvazia toda a coleção do usuário (Delete)
    Given path '/Books'
    And param UserId = userId
    And header Authorization = token
    When method delete
    Then status 204
    * print 'Ciclo de vida do acervo finalizado com sucesso.'