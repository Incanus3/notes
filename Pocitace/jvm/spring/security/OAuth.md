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
1. Third-party login and registration _(federated identity)_
2. First-party login and registration _(reverse federated identity)_
3. Enterprise login and registration _(federated identity with a twist)_
4. Third-party service authorization
5. First-party service authorization
6. Machine-to-machine authentication and authorization
7. Device login and registration