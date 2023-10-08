Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-09-10T15:21:47+02:00

====== objednavky ======
Created Tuesday 10 September 2013

mailova schranka pro odesilani mailu z objednavek:
objednavka@altopraha.cz, obj1244.xP
smtp.web4u.cz
465 - ssl/tls
25, 587 - starttls


== struktury dat ==
=== zmeny v tabulkach ===
- rozdelit firmy do 3 tabulek
- klient muze mit N od kazdeho typu firmy -> 3 join tably pro kazdy typ

- tabulky jidelny, retezce, zamestnavatele
- joiny client-zamestnavatel, client-retezec + typ vztahu, client-jidelna + typ vztahu
- jidelna ma foreign key na retezec (1:N pomer)

- nebo jidelny a retezce nerozlisovat - jedna tabulka + jedna join-table
- entita ma foreign key na rodice -> nema deti - je jidelnou
  + postihuje to, ze retezce a jidelny jsou skoro totez az na to, ze jidelna patri do retezce
  + snadne pridani jidelny do retezce nebo stravnika do retezce
  - nevyhoda - drahe vyhledani vsech stravoven klienta (je treba vyhledavat v rodicich)

- nebo potrebujeme N:N pomer mezi retezci a jidelnami - dalsi join table
- napr. jidelna prijima slevove karty vice retezcu (obecnejsi)
- v tu chvili jeste drazsi vyhledani vsech stravoven klienta (uz neni strom nybrz orientovany graf)

- nebo klient ma vztah jenom se stravovnami
  - drahe pridani jidelny do retezce (treba pridat vztahy pro vsechny klienty retezce) nebo klienta do retezce

- finalni podoba:
- tabulka zamestnavatelu je extra
- tabulka zradelen a retezcu je dohromady
  -> klient ma vztah (daneho typu) se subjektem, ktery je bud zradelnou, nebo
     retezcem -> join table klient-zarizeni-typ vztahu
  - v tabulce je sloupec s typem (retezec nebo zradelna), abych mohl levne
    zjistit, zda mam rovnou zobrazit jidelak, nebo nejdriv selektor jidelen
  + join table zradelen a retezcu (tedy v ramci jedne tabulky) - N:N pomer
  - tento vztah je ale jednourovnovy - nejsou podretezce, apod.

- pri prihlaseni z terminalu je defaultem jidelna, na kterou je terminal
  registrovan
- pri prihlaseni z webu je defaultem posledni vybrana jidelna

=== jednoznacna identifikace klienta ===
* client.id (primary key v tabulce client) - svazuje klienta s userem
* (client_id,retezec_firma_key) nebo (card_id,retezec_firma_key) - pokud je
  klient svazan s retezcem
* (client_id,jidelna_firma_key) nebo (card_id,jidelna_firma_key) - pokud je
  klient svazan s jidelnou
  * aplikace musi byt schopna tyto moznosti rozlisit - bud sloupec, ktery rika,
    zda jidelna, nebo retezec, nebo vyplnene jen jedno
* email - muze slouzit k overeni identity klienta, pokud by se klienti sami
  registrovali, pak nutne, aby byl u kazdeho klienta vyplnen
* pripadne phone

=== prihlaseni uzivatele ===
* login - bud nejaky obecny unikatni login, nebo email
* dvojice card_id a retezec_firma_key/jidelna_firma_key - aplikace musi vedet,
  co z toho, identifikator retezce/jidelny bude ulozen v cookie na registrovanem
  terminalu
* pripadne to same s client_id misto

===== registrace uzivatelu =====
[ ] zjistit od evzi, jak probiha registrace klientu - klient musi byt
    registrovan v jidelne/retezci a take mit informace od zamestnavatele kvuli
    dotaci
[ ] na zaklade toho zuzit moznosti a poslat maila olze

možnosti:
1. uzivatele se sami neregistruji - pri vytvoreni klienta je jim vytvoren uzivatel
  * pridelen login, vychozi heslo (problem s vytvorenim hashe hesla, treba
    nastavit defaulty v tabulce)
2. uzivateli je nejprve vytvoren zaznam v tabulce klientu a sdeleny udaje, ktere
   ho v tabulce klientu jednoznacne identifikuji (ty pak zada pri registraci), tedy
  * idealne email, pokud neni prilis silny pozadavek, aby mel kazdy klient
    email, vyhoda - overeni registrace emailem - nehrozi, ze uzivatel zkusi jiny
    udaj a trefi se
	* jinak bud pridat nejaky obecne unikatni identifikator - novy sloupec
	* nebo client.id - interni, asi nechceme davat klientum
  * nebo dvojice (client_id,retezec_firma_key) pripadne
    (client_id,jidelna_firma_key) - tentyz problem + pri registraci musi vybrat,
    zda je svazan s jidelnou nebo retezcem
3. uzivatel se nejprve registruje na webu, pak teprve v jidelne/retezci, ktera
   ho sparuje s klientem
	* vyhoda - nemusi sam resit udaje, ktere poji uzivatele s klientem

===== Todo =====
[ ] predelat modely firem podle noveho planu
  [ ] oddelit zamestnavatele extra
  [ ] companies postihuje zradelny a retezce - sloupec na typ zustava
  [ ] klient muze mit libovolne mnoho vztahu s firmami
  [ ] zradelna muze patrit k vice retezcum (prijimat jejich slevove karty)
  [ ] u firmy vyhodit politiku porcí, ta je vázána ke klientu - dodelat u klienta

[ ] User::Create and User::Update returns client even when associations can't be
    found, which is nice because we can render form with the invalid user, but
    if an optional association isn't found, we don't learn about it, which is
    dangerous
    - the services should probably set validation errors on associations that
      weren't found
[ ] redirect to the right pages after sign in, sign out, sign up, confirmation,
    etc., otherwise we get error, when logging out from admin and in as client
[ ] udelat feature specy na vsechny stranky, vcetne administrace - bude
    pristupna babe
[ ] zacit resit administracni prava
[ ] formular pro vyber jidla z optionu nastavuje rucne wrapper kolem radio
    buttonu - zkusit vytvorit rozumny initializer (podle receptu)
[ ] historie objednavek radit podle data
    [ ] projit vsechny wice grid views a zprovoznit razeni a filtrovani podle
        vsech potrebnych atributu
[ ] klienti se budou vytvaret i v pepinove klikatku - mit json routu na
    vytvoreni usera
[ ] u jidla podporovat upload obrazku
[ ] oznacit vsechny povinny pole

[ ] vytvoreni klienta a uzivatele
  [ ] administrace -> klienti -> vytvořit - vedle mailu zaskrtavadlo 'chci i
      webovyho usera' - pouzit mail
      [*] pridat zaskrtavadlo
      [*] vytvorit form objekt na zpracovani formulare
      [*] oddelit new a edit form - edit nemuze mit zaskrtavadlo
      [ ] vytvaret uzivatele
          [*] nejprve s defaultním heslem
          [*] odeslat potvrzení
          [ ] pak ideálně nastavit heslo v rámci potvrzení
      [*] mazat uzivatele pri smazani klienta
  [ ] vyhodit id klienta, bude se vytvaret automaticky - domluvit s pepinem
  [ ] hodnoty jidelna, retezec, zamestnavatel musi podporovat prazdnou hodnotu
      jako vychozi
[ ] v dennim menu u objednavani ala card pri prihlaseni z webu nad datem vybirat
    jidelnu
[ ] rozpoznat konec id karty a odeslat formular na prihlaseni - vyresit s
    pepinem vsechny mozne typy karet
[ ] u politiky více porcí limitovat na hodnotu kreditu - domluvit, jak zjistim
[ ] casem podporovat vic moznosti designu
[ ] v production odchytit v application controlleru vsechny chyby s redirectem
    na root_path
[ ] add logging of important actions

=== Pro Lenku ===
- vytvoření klienta
  - administrace -> klienti -> vytvořit - přidat checkbox 'vytvořit uživatele'
    (hotovo)
  - vytvořit uživatele svázaného s klientem, se stejným mailem a výchozím heslem
    (hotovo)
  - poslat potvrzovací email (hotovo)
  - při smazání klienta smazat uživatele
  - co při úpravě mailu klienta?
  - jaký by měl být default hesla?
  - hodnoty jídelna, řetězec, zaměstnavatel jako nepovinné
  - co z nich je teda povinné? buď jídelna nebo řetězec? pokud jídelna, tak i
    zaměstnavatel?
  - podporovat vzdálené vytvoření klienta dotazem z pepínova klikátka
- zbavit se client_id - bude se používat interní id z databáze - dořešit s
  pepínem

- politiku počtu porcí vázat ke klientu, nikoli k jídelně
- pokud je klient vázán k řetězci, vybírat v denním menu jídelnu z řetězce
  - omezovat počet porcí podle zůstatku peněz/bodů (odkud zjistím?)

- historie objednávek
  - řadit podle data (zatím řazeno podle data vytvoření, nikoli na kdy je
    objednáno)
- přihlášení
  - až bude jasný formát id karty, rozpoznat konec a přihlásit automaticky

=== Error handling ===
[ ] what to do exactly upon errors, that shouldn't happen - the views shouldn't
    allow this path
* e.g. multiple portion daily menu - decrement of non-existent order - button is
  disabled
  * something can go terribly wrong, when an error in view appears and the bad
    path is accessible
	* views are hard to test, as opposed to controllers
  * => make controllers as bulletproof as possible, even it it means double
    protection
* possibilities
  * don't handle the error cases at all - would result in negative portions
    ordered - can't afford that -> prevent data inconsistency
  * **let rails error to be raised - (+) less work, (-) hard to tell quickly,
    what's going on when error occurs (and I forget the implementation)**
  * **raise custom errors - (+) more obvious what just happened, (-) may not be
    worth translating the errors, (-) may hide some underlying debug info**
  * show custom error page - in production mode, error page is displayed anyway,
    (-) impossible debug - must be switchable -> too much work for now
  * only redirect back and display alert - (-) we don't find out about this
    error, unless the user reports it
* **let's not translate rails errors for now, when code is not that complex,
  start translating them if it starts to be**

* could be used in OrderGetter
Book.where(:title => 'Tale of Two Cities').first_or_create do |book|
  book.author = 'Charles Dickens'
  book.published_year = 1859
end


=== Authentication ===
[ ] popremyslet, jestli neresit autentifikaci pomoci card_id na urovni modelu a ne controlleru
	* pravdepodobne nejlepsi zpusob
	* https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
	* vytvorit virtualni atribut v modelu - nepr. login
	* nastavit v devise initializeru config.authentication_keys na login
  * upravit find_for_database_authentication / find_for_authentication /
    find_first_by_auth_conditions - see link and doc
	* upravit views - sessions/new (prihlaseni) - f.text_field :login
