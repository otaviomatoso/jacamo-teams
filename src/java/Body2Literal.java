import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.json.JSONObject;

public class Body2Literal implements Processor {

	@Override
	public void process(Exchange exchange) throws Exception {
		String functor = exchange.getIn().getHeader("Functor").toString();
		Object args = exchange.getIn().getHeader("Args");
		String body = exchange.getIn().getBody(String.class);
		String term = new String();

		if (args != null){
			String[] array = args.toString().split(","); // [token_type, access_token]
			JSONObject json = new JSONObject(body);
			term = json.getString(array[0]) + " " + json.getString(array[1]);
		}else{
			term = body;
		}

		String literal = functor + "(\"" + term + "\")";
		// System.out.println("LITERAL = " + literal);
		exchange.getIn().setBody(literal);
  }
}
