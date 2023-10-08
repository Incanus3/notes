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
### poznamky
* HttpSecurity:
	* pokud neni AuthenticationManager nastaven explicitne, tak se v `beforeConfigure()` vytvari volanim `getAuthenticationRegistry().build()`, kde `getAuthenticationRegistry()` vraci `AuthenticationManagerBuilder` (ziskany pomoci `getSharedObject()`)