### Uzitecne odkazy
- https://oauth.net/2/
- https://fusionauth.io/articles/oauth/modern-guide-to-oauth
- https://fusionauth.io/articles/oauth/saml-vs-oauth
- https://fusionauth.io/docs/get-started/
- https://fusionauth.io/docs/
- https://aaronparecki.com/oauth-2-simplified/
- https://oauth.tools/

### Mody (podle FusionAuth nomenklatury)
1. Local login and registration
	- the same provider (e.g. sentica) controls both the application (e.g. qwazar) and the auth server (e.g. FusionAuth)
	- application redirects to OAuth server pages that handle the registration and log-in, then they're redirected back
	- the OAuth server may be tightly integrated so its pages look consistent with the application's and the user might not even be aware he's left the application
2. Third-party login and registration _(federated identity)_
	- the application provider doesn't control the auth server
	- typical social login ("log in with ...") buttons - user is aware that he's left the application
	- in some cases, there's also additional "permission grant screen" with sth like "Qwazar wants to access you're user info"
	- the application can usually also call some of the auth provider APIs, e.g. to get the user's contact list
	- this can even be combined with mode *1* - application redirects user to local auth server (e.g. FusionAuth), which then provides the ability to log in using some 3rd party service (e.g. google)
3. First-party login and registration _(reverse federated identity)_
	- this is basically mode *2* from the other side - you are the auth server provider and some application is consuming you're services to delegate their auth to you
4. Enterprise login and registration _(federated identity with a twist)_
5. Third-party service authorization
	- doesn't handle in-application auth externally, but provides access to some external API
	- user is already logged into the application (either internally, or using some of the previous modes), but he wants to access some external service, for example post on fb, so the application will show sth like "connect your fb account" button, which will redirect to fb oauth page, where user will log in and authorize your application, the application will then get some access token which will allow it to call fb API with your account
6. First-party service authorization
	- like mode *5*, but reversed - you're the fb and someone application redirects to you're OAuth to call your APIs using their users' accounts
7. Machine-to-machine authentication and authorization
	- one service needs to call other service with authentication
	- the flow - service 1 requests auth token from auth service (with some credentials), auth service verifies credentials and sends back the token, service 1 calls service 2 and includes the token, service 2 verifies the token agains auth service and only then does the thing it's been asked to do
8. Device login and registration

### Schemata, ktera by sla pouzit v qwazaru
1. externi login, interagujici primo s FE
	- FE redirectuje na externi login, ten redirectuje zpet na FE, FE ziska z auth serveru token, ten pouziva pri komunikaci s BE, BE overuje proti auth serveru
 2. externi login bez nutnosti prime interakce FE s auth serverem
	- FE redirectuje na BE endpoint, ten redirectuje na externi login, ten redirectuje zpet na BE, BE ziska nebo vytvori token, redirectuje zpet na FE s tim, ze mu token preda
  3. "interni" login
	- FE obsahuje login form (tak jako doted), ktery postuje na BE endpoint (tak jako doted), BE overi udaje proti auth serveru a bud vytvori, nebo ziska od auth serveru token, ten pak vrati FE
	- pro FE nejjednodussi reseni - nevyzaduje vubec zadnou upravu