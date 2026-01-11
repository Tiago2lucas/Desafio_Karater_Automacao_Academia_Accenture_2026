package utils;

import net.datafaker.Faker;

import java.util.Locale;

public class DateGenerator {


    private static final Faker faker = new Faker(new Locale("pt-BR"));

    public static String gerarNomeUsuarioValido() {
        return faker.name().fullName();
    }

    public static String gerarSenhaUsuarioValida() {

        return faker.regexify("[A-Z]{3}[a-z]{3}[0-9]{2}[!@#$%^&*]{3}");
    }

    public static String geraSenhaUsuarioInvalida(){
        return faker.regexify("[A-Z]{0}[a-z]{3}[0-9]{1}[!@#$%^&*]{1}");
    }
}
