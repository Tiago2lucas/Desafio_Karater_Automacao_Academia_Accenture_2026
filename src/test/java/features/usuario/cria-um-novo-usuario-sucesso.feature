Feature: Cadastrar um novo usuário com sucesso


  Background:
    Given url urlBase
    * def Generator = Java.type('utils.DateGenerator')

    * def nomeSorteado = Generator.gerarNomeUsuarioValido()
    * def senhaSorteada = Generator.gerarSenhaUsuarioValida()

    * def payload = read('DadosTesteUsuario/cadastrar-usuário-dado-validos.json')

    * set payload.userName = nomeSorteado
    * set payload.password = senhaSorteada

@smoke
  Scenario: Cria usuário com sucessos
    Given path '/Account/v1/User'
    And request payload
    When method post
    Then status 201

    And match response.username == payload.userName
    And match response.userID == "#notnull"

    * print 'Usuário gerado:', payload.userName
    * print 'Senha gerada:', payload.password
    * print 'Meu JSON agora está assim:', payload

