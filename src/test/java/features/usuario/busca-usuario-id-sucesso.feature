


Feature: busca usuarios por id

  Background:
    Given url urlBase
  * def resultadoToken = call read('classpath:features/usuario/gera-token-usuario-sucesso.feature')

    @usuarioEncontradoId
  Scenario: buscando usuario valido do sistema da Api

      Given path '/Account/v1/User', resultadoToken.idUsuario
      And header Authorization = 'Bearer ' + resultadoToken.tokenGeradoSucesso
      And header Accept = 'application/json'
      When method get
      Then status 200

    * print 'usuario encontrado:', response.body

      * match response.username != "#notnull"