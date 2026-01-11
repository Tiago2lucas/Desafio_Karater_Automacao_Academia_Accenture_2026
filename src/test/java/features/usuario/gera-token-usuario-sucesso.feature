Feature: Gera token usuario


  Background:
    Given url urlBase
    * def resultado = call read('classpath:features/usuario/cria-um-novo-usuario-sucesso.feature')
    * def usuarioCriado = resultado.nomeSorteado
    * def senhaCriada = resultado.senhaSorteada

@GeraToken
  Scenario: gera token de usuario valido

    Given path '/Account/v1/GenerateToken'
    And request { userName: '#(usuarioCriado)', password: '#(senhaCriada)' }
    When method post
    Then status 200
    And match response.token != null

  * def tokeGerado = response.token

  * print 'token gerado: ', response.token

