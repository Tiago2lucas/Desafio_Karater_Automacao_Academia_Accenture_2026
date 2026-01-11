Feature: Autoriza usuario valido no sistema

Background:
  Given url urlBase
  * def resultado = call read('classpath:features/usuario/gera-token-usuario-sucesso.feature')
  * def usuarioValido = resultado.usuarioCriado
  * def senhaValida = resultado.senhaValida

  @Autorizacao
  Scenario: Validar que usuário cadastrado está autorizado com sucesso

    Given path '/Account/v1/Authorized'
    And header Autorization = 'Bearer resultado.tokenGeradoSucesso'
    And request { userName: '#(usuarioValido)', password: '#(senhaValida)' }
    When method post
    Then status 200
    And match  response == 'true'
    * print 'usuario autorizado confirmacao com:', response