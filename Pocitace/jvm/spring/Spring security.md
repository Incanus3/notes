### uzitecne odkazy

https://docs.spring.io/spring-security/reference/5.7-SNAPSHOT/index.html
https://docs.spring.io/spring-security/reference/5.7-SNAPSHOT/servlet/authentication/architecture.html
https://www.baeldung.com/kotlin/spring-security-dsl
https://github.com/spring-projects/spring-security-samples

### aktualne pouzivame
- spring-boot-starter-security -> 2.7.16
- spring-security-core:5.7.11
- spring-security-config:5.7.11
- spring-security-crypto:5.7.11
- spring-security-web:5.7.11
- spring-security-ldap -> 5.7.11
- spring-ldap-core:2.4.1

### entity, se kterymi spring security pracuje
* `PasswordEncoder` interface
	* konkretni implementace, napr. `BCryptPasswordEncoder`
	* `DelegatingPasswordEncoder` - umoznuje ukladani hesel v ruznych formatech, soucasti ulozeni je prefix s nazvem formatu
* `SecurityContextHolder` - The `SecurityContextHolder` is where Spring Security stores the details of who is authenticated
* `SecurityContext` - is obtained from the `SecurityContextHolder` and contains the `Authentication` of the currently authenticated user
* `Authentication` - Can be the input to `AuthenticationManager` to provide the credentials a user has provided to authenticate or the current user from the `SecurityContext`
* `GrantedAuthority` - An authority that is granted to the principal on the `Authentication` (i.e. roles, scopes, etc)
* `AuthenticationManager` - the API that defines how Spring Security’s Filters perform authentication
	* `ProviderManager` - the most common implementation of `AuthenticationManager`
* `AuthenticationProvider` - used by `ProviderManager` to perform a specific type of authentication
	* [`ProviderManager`](https://docs.spring.io/spring-security/site/docs/current/api/org/springframework/security/authentication/ProviderManager.html) is the most commonly used implementation of [`AuthenticationManager`](https://docs.spring.io/spring-security/reference/5.7-SNAPSHOT/servlet/authentication/architecture.html#servlet-authentication-authenticationmanager). `ProviderManager` delegates to a `List` of [`AuthenticationProvider`s](https://docs.spring.io/spring-security/reference/5.7-SNAPSHOT/servlet/authentication/architecture.html#servlet-authentication-authenticationprovider). Each `AuthenticationProvider` has an opportunity to indicate that authentication should be successful, fail, or indicate it cannot make a decision and allow a downstream `AuthenticationProvider` to decide.
	 * `ProviderManager` also allows configuring an optional parent `AuthenticationManager` which is consulted in the event that no `AuthenticationProvider` can perform authentication.
* Request Credentials with `AuthenticationEntryPoint` - used for requesting credentials from a client (i.e. redirecting to a log in page, sending a WWW-Authenticate response, etc.)
* `AbstractAuthenticationProcessingFilter` - a base Filter used for authentication. This also gives a good idea of the high level flow of authentication and how pieces work together

### relevantni konfiguracni classy
* `AuthenticationConfiguration`
* `HttpSecurityConfiguration`
* `WebSecurityConfiguration`
* `DelegatingWebMvcConfiguration`

- v jakem poradi se vyhodnocuji?
	- `HttpSecurityConfiguration` (a `WebSecurityConfigurerAdapter`) maji privatni field na `AuthenticationConfiguration`, ktery se nastavuje v `@Autowired` setteru
	- `@EnableWebSecurity` importuje `HttpSecurityConfiguration`, `WebSecurityConfiguration` (a taky `SpringWebMvcImportSelector` a `OAuth2ImportSelector`) a pridava `@EnableGlobalAuthentication`
		- tuhle anotaci mame na `SecurityConfigurationBase`
	- `GlobalMethodSecurityConfiguration` taha `AuthenticationConfiguration` z kontextu (primo pres `getBean`)
	- `@EnableGlobalAuthentication` importuje `AuthenticationConfiguration`
		- `@EnableGlobalMethodSecurity` pridava `@EnableGlobalAuthentication`
			- tuhle anotaci mame v projektu na `MethodSecurityConfiguration`, otazka je, zda-li je stale potreba, protoze method security se podle me nepouziva

### poznamky
* `HttpSecurity`:
	* pokud neni `AuthenticationManager` nastaven explicitne, tak se v `beforeConfigure()` vytvari volanim `getAuthenticationRegistry().build()`, kde `getAuthenticationRegistry()` vraci `AuthenticationManagerBuilder` (ziskany pomoci `getSharedObject()`)
 * `AuthenticationManagerBuilder` by mel byt poskytovan `AuthenticationConfiguration` classou, jeho vytvoreni ve skutecnosti neni extremne slozity

- `ProviderManager` je v podstate jedinou pouzitelnou implementaci `AuthenticationManager`u (pokud nechceme implementovat vlastni), vsechny ostatni implementace jsou privatni

- v pripade ldapu bude nejspis lepsi pouzit `ProviderManager`
- na druhou stranu, `AuthenticationManagerBuilder` ma metodu `ldapAuthentication()`,
  ktera aplikuje `LdapAuthenticationProviderConfigurer`,
  ktery pak muze byt (presumably) dale konfigurovan
- `AMB` ve skutecnosti vraci `ProviderManager`, vychazejici z registrovanych
  `authenticationProviders` a `parentAuthenticationManager`u (pokud byl nastaven)
	- providery lze konfigurovat bud manualne volanim `authenticationProvider()`, nebo je typicky registruje configurer (viz `LdapAuthenticationProviderConfigurer.configure()`)
	
```
// @Bean
// override fun authenticationManager(
//     userDetailsService: UserDetailsService,
//     objectPostProcessor: ObjectPostProcessor<Any>,
// ): AuthenticationManager {
//     // return super.authenticationManager()
//
//     tady mam akorat trochu obavu, ze pokud si vytvorime vlastni instanci builderu,
//     tak jiny classy, ktery pouzivaji shared builder, ho nebudou mit spravne nastavenej
//     problem ale je, ze na shared builderu nemuzeme zavolat build(), protoze ten se smi zavolat
//     jenom jednou a uz se vola jinde
//     return AuthenticationManagerBuilder(objectPostProcessor).also {
//         it.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder)
//     }.build()
// }
```

`UserDetailService` se nejspis pouzije automaticky, pokud je nastavena username&password autentifikace, tedy aktualne bud Form, Basic, nebo Digest
- v configureru by tedy melo nejspis jit dohledat neco, co springu rekne, ze SimpleAuth je
  username&password autentifikace

`UserDetailsService` se vola z `DaoAuthenticationProvideru` (coz je jeden z provideru, registrovanych v `ProviderManageru` `AuthenticationManagerBuilderem`,
viz `(Abstract)DaoAuthenticationConfigurer`)
- `AuthenticationManagerBuilder` aplikuje `DaoAuthenticationConfigurer` pri volani
  `.userDetailsService()`

`AuthenticationConfiguration.getAuthenticationManager()` builduje `AuthenticationManager` pomoci `AuthenticationManagerBuilder` beanu (ktery sama providuje), ale s tim, ze pokud `build()` vrati null (kdy se to muze stat?), nastavi si `this.authanticationManager` primo z `AuthenticationManager` beanu (ktery muzeme providenout my)
- prubeh buildu:
  - `AbstractSecurityBuilder.build()` vola `doBuild()` s tim, ze pokud uz je sbuildovano, hodi vyjimku
  - `AbstractConfiguredSecurityBuilder.doBuild()` vola postupne
    - `beforeInit()` - defaultni implementace nedela nic, nezda se, ze by nekdo overridoval
    - `init()` - zavola `init()` na vsechny configurery
    - `beforeConfigure()` - defaultni implementace nedela nic, `HttpSecurity` overriduje tak, ze pokud uz je nastaven `this.authenticationManager`, nastavi ho jako shared object, pokud neni, sbuilduje (pomoci `getAuthenticationRegistry().build()`), nastavi jako shared object, ale neulozi do `this.authenticationManager`
    - `configure()` - zavola configure na vsechny configurery
    - `preformBuild()` - je abstract, overriduje se v `AuthenticationManagerBuilderu`, `HttpSecurity` a `WebSecurity`
      - `AuthenticationManagerBuilder.performBuild()`:
        - pokud neni nakonfigurovan (nebyl nastaven parent a ani jeden provider), zaloguje
          debug a vrati null, HA!
        - vytvori `ProviderManager` s parentem a providery, donastavi dalsi propky
        - prozene `postProcess()`em a vrati

-> pokud zajistime, ze se nezaregistruje ani `parentAuthenticationManager()`,
   ani zadny `authenticationProvider()`, tak by se mel pouzit manazer,
   ktery vratime z `AuthenticationManager` `@Bean`u

`AuthenticationConfiguration.getAuthenticationManager()` se vola na 3 mistech:
- `GlobalMethodSecurityConfiguration.authenticationManager()`
- `HttpSecurityConfiguration.authenticationManager()`
  - vola se z `HSC.httpSecurity()`, coz je bean, ktera vraci `HttpSecurity`, coz znamena, ze
    jakmile injectneme `HttpSecurity`, tak uz nemuzeme overridnout `authenticationManager`
- `WebSecurityConfigurationAdapter.authenticationManager()`
  - ten je deprecated a snad uz by se volat nemel
  - vola se z `WebSecurityConfigurerAdapter.getHttp()` <- `init.()` <- `AbstractConfiguredSecurityBuilder.init(),` coz tedy znamena, ze jde o `SecurityBuilder`, ktery se musi nekde registrovat
  - `AutowiredWebSecurityConfigurersIgnoreParents.getWebSecurityConfigurers()` najde v kontextu vsechny beany typu `WebSecurityConfigurer` (coz je i `WSCAdapter`)
	  - vola se z `WebSecurityConfiguration.setFilterChainProxySecurityConfigurer()`, coz je `@Autowired` setter

### LDAP
- https://docs.spring.io/spring-security/reference/5.7-SNAPSHOT/servlet/authentication/passwords/ldap.html
- https://www.zytrax.com/books/ldap/