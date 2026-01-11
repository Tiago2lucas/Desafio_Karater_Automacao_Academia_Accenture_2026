Feature:Cria conta com senha invalida


  Background:
    Given url urlBase
    * def Generator = Java.type('utils.DateGenerator');




  Scenario: conta com senha invalida

    Given path '/Account/v1/User'
    And request payload
    When method post
    Then status 201

    And match response.username ==
    And match response.userID == "#notnull"

    * print 'Usuário gerado:',
    * print 'Senha gerada:',

