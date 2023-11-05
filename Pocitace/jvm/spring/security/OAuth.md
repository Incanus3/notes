### Uzitecne odkazy
- https://oauth.net/2/
- https://fusionauth.io/articles/oauth/modern-guide-to-oauth
- https://fusionauth.io/articles/oauth/saml-vs-oauth
- https://fusionauth.io/docs/get-started/
- https://fusionauth.io/docs/quickstarts/
- https://fusionauth.io/docs/
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
	- used to log in to the user's account on a device that doesn't have a keyboard
	- for example smart TV or a game console might show a qr code that the user will scan and authenticate using his phone

### OAuth grants
- grants are authentication flows for obtaining access tokens from the Authorization Server
- the grant encapsulates a process, data flow and rules used to generate a token
- the core OAuth2 grants (as outlined in RFC 6749) are:
1. Authorization Code grant - This grant has a one time authorization code generated after authentication. This is exchanged for the token using server side code.
2. Implicit grant - A simplified flow to be used by browser based applications implemented with JavaScript. This is a legacy grant. Don’t use this grant.
3. Resource Owner’s Password Credentials grant - Helpful when the username and password are required for authorization. Also called the Password grant. It should only be used if there is a high level of trust between the Resource Owner and the third-party application or for migrating from legacy systems to OAuth2.
4. Client Credentials grant - A useful grant when the application is trying to act on behalf of itself without the user’s presence. An example is the Printing Website calling into an Invoice Generation service to create invoices for the prints. This is not done for any user, but instead for the Printing Website itself.
5. Device grant - Enables users to gain access to an application or device by allowing it to use account information from another application or device.

### Schemata, ktera by sla pouzit v qwazaru
1. externi login, interagujici primo s FE
	- FE redirectuje na externi login, ten redirectuje zpet na FE, FE ziska z auth serveru token, ten pouziva pri komunikaci s BE, BE overuje proti auth serveru
 2. externi login bez nutnosti prime interakce FE s auth serverem
	- FE redirectuje na BE endpoint, ten redirectuje na externi login, ten redirectuje zpet na BE, BE ziska nebo vytvori token, redirectuje zpet na FE s tim, ze mu token preda
  3. "interni" login
	- FE obsahuje login form (tak jako doted), ktery postuje na BE endpoint (tak jako doted), BE overi udaje proti auth serveru a bud vytvori, nebo ziska od auth serveru token, ten pak vrati FE
	- pro FE nejjednodussi reseni - nevyzaduje vubec zadnou upravu

### Zakladni postup rozbehnuti FusionAuth
- nainstalovat a spustit, nejjednoduseji pres docker compose
- projit zakladnim wizardem pro nastaveni superusera
- vytvorit aplikaci ![[Screenshot from 2023-11-05 19-54-17.png]]
- vytvorit uzivatele a pridat mu registraci do aplikace
![[Screenshot from 2023-11-05 19-58-53.png]]
- pro schema *3* (viz predchozi sekce) vytvorit API key (idealne omezit jen na nektere endpointy, pokud se nevybere nic, funguje na vsechno)
![[Screenshot from 2023-11-05 20-00-22.png]]
- uzivatele pak lze autentifikovat takto:
![[Screenshot from 2023-11-05 20-02-15.png]]
- pro vice detailu, viz https://fusionauth.io/articles/oauth/modern-guide-to-oauth#authorization-code-grant