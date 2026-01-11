Feature:Cria conta com senha invalida


  Background:
    Given url urlBase
    * def Generator = Java.type('utils.DateGenerator');

    * def nomeUsuarioValido = Generator.gerarNomeUsuarioValido()
    * def senhaUsuarioInvalido = Generator.geraSenhaUsuarioInvalida()

    * def payload = read('DadosTesteUsuario/cadastrar-usuário-dado-invalidos.json')

    * def payloadSenhaInvalida = read('DadosTesteUsuario/validacaoSenhaIncorreta.json')

    * set payload.userName = nomeUsuarioValido
    * set payload.password = senhaUsuarioInvalido

    @Negative
  Scenario: conta com senha invalida

    Given path '/Account/v1/User'
    And request payload
    When method post
    Then status 400

      And match response.code == payloadSenhaInvalida.code
      And match response.message == payloadSenhaInvalida.message

    * print 'Usuário gerado:', payload.userName
    * print 'Senha gerada invalida:', payload.password
    * print 'Meu JSON agora está assim:', payload


