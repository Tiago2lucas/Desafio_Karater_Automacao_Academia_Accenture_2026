package utils;

import net.datafaker.Faker;

import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;

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


    public static String getIsbnAleatorio(List<Map<String, Object>> books) {
        if (books == null || books.isEmpty()) {
            return null;
        }
        int index = new Random().nextInt(books.size());
        return books.get(index).get("isbn").toString();
    }

}
