import org.apache.camel.Exchange;
import org.apache.camel.Processor;

public class SetBody implements Processor {

	@Override
	public void process(Exchange exchange) throws Exception {
		String msg = exchange.getProperty("Msg").toString();
		String jsonBody = "{\"body\": {\"content\":\"" + msg + "\"}}";
		exchange.getIn().setBody(jsonBody);
  }
}
