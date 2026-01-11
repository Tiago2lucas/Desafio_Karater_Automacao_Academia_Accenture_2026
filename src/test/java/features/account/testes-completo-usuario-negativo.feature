Feature: Testes de Negativo e Exceção no Ciclo de Vida do Usuário

  Background:
    Given url urlBaseUser
    * def setup = callonce read('DadosTesteUsuario/usuario-config.feature')
    * def idValido = setup.id
    * def usuarioSemToken = setup.payloadGeral.userName
    * def usuarioValido = setup.credenciais.userName
    * def Generator = Java.type('utils.DateGenerator')

  @FluxoCompletoAccountNegativo
  Scenario Outline: Validação de falhas críticas - <cenario>

    Given path <rota>
    And request <payload>
    When method <metodo>
    Then status <status_esperado>
    And match response.message contains '#string'
    * print 'Sucesso no teste negativo:', cenario

    Examples:
      | cenario                                       | rota                | metodo | status_esperado | payload                                                                        |
      | "Campo senha curta, sem sucesso"              | "User"              | post   | 400             | { userName: '#(Generator.gerarNomeUsuarioValido())', password: '#(Generator.geraSenhaUsuarioInvalida())' }    |
      | "Usuario sem senha, sem possiblidade de token"| "GenerateToken"     | post   | 400             | { userName: "#(usuarioValido)" }                                                    |
      | "Verifica autorizacao de usuario sem Senha"   | "Authorized"        | post   | 400             | { userName: "#(usuarioValido)" }                                                    |
      | "Usuario nao autorizado"                      | "User", idValido    | get    | 401             | { userName: "#(usuarioSemToken)"}                                                                             |