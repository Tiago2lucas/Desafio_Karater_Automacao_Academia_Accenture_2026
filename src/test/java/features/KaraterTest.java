package features;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class KaraterTest {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:features").tags("@FluxoCompletoNegativo")

                //.outputCucumberJson(true)
                .parallel(6);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}
