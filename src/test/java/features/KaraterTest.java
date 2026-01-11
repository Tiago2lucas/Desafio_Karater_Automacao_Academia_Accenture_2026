package features;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
        import org.junit.jupiter.api.Test;

class KaraterTest {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:features")
                .tags("@FluxoCompletoAccountPositivo")

                //.outputCucumberJson(true)
                .parallel(2);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}
