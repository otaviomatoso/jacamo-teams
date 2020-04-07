/* Initial beliefs and rules */
msg("Hi from Bob").
teams_id("975cc33d-02ee-45b8-9aed-6210c59f7963").
channel_id("19:2e20647f40aa4f27bc6b2e2421244f84@thread.tacv2").
tenant("43d96045-5bae-4d3d-b17b-8d2a22bc5158").
client_id("350114b6-5a6d-4914-b7b9-1ee1aecdc54b").
client_secret("?JG31JF9cIhAk5?tHrqjzclC/-9[fT9A").
response_type("code").
response_mode("query").
scope("group.readwrite.all").
redirect_uri("http://localhost:8888/token").

/* Initial goals */
!start.

/* Plans */
+!start : tenant(Tenant) & client_id(Client) & response_type(ResType) & response_mode(ResMode) & scope(Scope) & redirect_uri(Uri)
	<- 	.print("Agent started.");
			focus(oauth);
			// get_code(Tenant,Client,ResType,ResMode,Scope,Uri);
			.

+code(Code) : tenant(Tenant) & client_id(Client) & client_secret(Secret) & scope(Scope) & redirect_uri(Uri)
	<-  .print("Code received.");
			.print("Getting token...");
			get_token(Tenant,Client,Secret,Code,Scope,Uri);
		  .

+token(X) : teams_id(T) & channel_id(C) & msg(M)
	<-  .print("Token received.");
			.print("Sending Hi to Teams...");
			send_msg(X,T,C,M);
			.

+msg_status(X)
	<- .print("Status from sent message - ", X).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }

// https://login.microsoftonline.com/43d96045-5bae-4d3d-b17b-8d2a22bc5158/oauth2/v2.0/authorize?client_id=350114b6-5a6d-4914-b7b9-1ee1aecdc54b&response_type=code&redirect_uri=http://localhost:8888/token&response_mode=query&scope=group.readwrite.all
