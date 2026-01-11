Feature: Testes de Negativo e Exceção no Ciclo de Vida do Usuário

  Background:
    * url urlBaseUser
    * def setup = callonce read('classpath:features/usuario/DadosTesteUsuario/usuario-config.feature')
    * def idValido = setup.id
    * def usuarioValido = setup.credenciais.userName
    * def Generator = Java.type('utils.DateGenerator')

  @FluxoCompletoNegativo
  Scenario Outline: Validação de falhas críticas - <cenario>

    Given path <rota>
    And request <payload>
    When method <metodo>
    Then status <status_esperado>
    And match response.message contains '#string'
    * print 'Sucesso no teste negativo:', cenario

    Examples:
      | cenario               | rota                                 | metodo | status_esperado | payload                                                                        |
      | "Senha Curta"         | "User"              | post   | 400             | { userName: '#(Generator.gerarNomeUsuarioValido())', password: '#(Generator.geraSenhaUsuarioInvalida())' }    |
      | "Token sem Senha"     | "GenerateToken"     | post   | 400             | { userName: "#(usuarioValido)" }                                                    |
      | "Autoriza sem Senha"  | "Authorized"        | post   | 400             | { userName: "#(usuarioValido)" }                                                    |
      | "Perfil sem Token"    | "User", idValido    | get    | 401             | {}                                                                             |