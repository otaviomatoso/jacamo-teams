import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import java.util.Map;

public class FormatProperties implements Processor {

	@Override
	public void process(Exchange exchange) throws Exception {
		Map<String, Object> props = exchange.getProperties();
    for (Map.Entry<String, Object> entry : props.entrySet()) {
				String value = entry.getValue().toString();
				value = value.replaceAll("\"", "");
				exchange.setProperty(entry.getKey(), value);
    }
	}
}
