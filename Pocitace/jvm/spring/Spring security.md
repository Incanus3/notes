### uzitecne odkazy

https://docs.spring.io/spring-security/reference/5.7-SNAPSHOT/index.html
https://docs.spring.io/spring-security/reference/5.7-SNAPSHOT/servlet/authentication/architecture.html
https://www.baeldung.com/kotlin/spring-security-dsl
https://github.com/spring-projects/spring-security-samples
### aktualne pouzivame

+--- org.springframework.boot:spring-boot-starter-security -> 2.7.16
|    +--- org.springframework.security:spring-security-config:5.7.11
|    |    +--- org.springframework.security:spring-security-core:5.7.11
|    |    |    +--- org.springframework.security:spring-security-crypto:5.7.11
|    \--- org.springframework.security:spring-security-web:5.7.11
|         +--- org.springframework.security:spring-security-core:5.7.11 (*)

+--- org.springframework.security:spring-security-ldap -> 5.7.11
|    +--- org.springframework.security:spring-security-core:5.7.11 (*)
|    \--- org.springframework.ldap:spring-ldap-core:2.4.1
### entity, se kterymi spring security pracuje
* `PasswordEncoder` interface
	* konkretni implementace, napr. `BCryptPasswordEncoder`
	* `DelegatingPasswordEncoder` - umoznuje ukladani hesel v ruznych formatech, soucasti ulozeni je prefix s nazvem formatu
 

    * SecurityContextHolder - The SecurityContextHolder is where Spring Security stores the details of who is authenticated.
    * SecurityContext - is obtained from the SecurityContextHolder and contains the Authentication of the currently authenticated user.
    * Authentication - Can be the input to AuthenticationManager to provide the credentials a user has provided to authenticate or the current user from the SecurityContext.
    * GrantedAuthority - An authority that is granted to the principal on the Authentication (i.e. roles, scopes, etc.)
    * AuthenticationManager - the API that defines how Spring Security’s Filters perform authentication.
    * ProviderManager - the most common implementation of AuthenticationManager.
    * AuthenticationProvider - used by ProviderManager to perform a specific type of authentication.
    * Request Credentials with AuthenticationEntryPoint - used for requesting credentials from a client (i.e. redirecting to a log in page, sending a WWW-Authenticate response, etc.)
    * AbstractAuthenticationProcessingFilter - a base Filter used for authentication. This also gives a good idea of the high level flow of authentication and how pieces work together.

### poznamky
* HttpSecurity:
	* pokud neni AuthenticationManager nastaven explicitne, tak se v `beforeConfigure()` vytvari volanim `getAuthenticationRegistry().build()`, kde `getAuthenticationRegistry()` vraci `AuthenticationManagerBuilder` (ziskany pomoci `getSharedObject()`)