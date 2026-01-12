Feature: Testes Negativos - Ciclo de Vida da BookStore

  Background:
    * url urlBaseBook
    * def setup = callonce read('DadosTesteLivros/usuario-livro-config.feature')
    * def tokenValido = setup.auth
    * def userIdValido = setup.id
    * def isbnReal = setup.isbnAleatorio
    * def authHeader = { Authorization: '#(tokenValido)', Accept: 'application/json' }

  @FluxoCompletoBookStoreNegativo
  Scenario Outline: Validação de falhas críticas - <cenario>

    Given path <rota>
    And headers <precisaAuth> ? authHeader : { Accept: 'application/json' }
    And params <parametros>
    And request <payload>
    When method <metodo>
    Then status <status_esperado>
    And match response.message contains <mensagem_esperada>
    * print 'Sucesso no cenário:', <cenario>

    Examples:
      | cenario                                      | rota              | metodo | status_esperado | precisaAuth | parametros               | payload                                                                        | mensagem_esperada         |
      | "ISBN não existente"                         | "Books"           | post   | 400             | true        | {}                       | { userId: '#(userIdValido)', collectionOfIsbns: [{ isbn: '0000000000' }] }     | 'not available'           |
      | "ISBN Malformado"                            | "Book"            | get    | 400             | false       | { ISBN: 'INVALID_@!#' }  | {}                                                                             | 'not available'           |
      | "Atualização do livro sem Token"             | "Books", isbnReal | put    | 401             | false       | {}                       | { userId: '#(userIdValido)', isbn: '#(isbnReal)' }                             | 'User not authorized!'    |
      | "Deleta livro do perfil do usuario nao valido"| "Book"            | delete | 401             | true        | {}                       | { userId: 'id-falso-123', isbn: '#(isbnReal)' }                                | 'User Id not correct!'    |
      | "Deleta todos os livros vinculado ao usuario"| "Books"           | delete | 401             | true        | { UserId: 'usuario-inv' }| {}                                                                             | 'User Id not correct!'    |