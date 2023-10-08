==== Objednavky ====

=== Prihlasovani ===
- pouze hajek bude mit prihlasovani mailem a kartou, ostatni se smiri s mailem a heslem
- bakare ma 2 formaty karet
  - stare (do 5 zadanych znaku) se vyhledaji trivialne - pouze se prependne chain prefix
  - nove (od 7 zadanych znaku) maji v db zadanych pouze 6, ze zadaneho cisla se vezme poslednich 7
    znaku a usekne se posledni, techto 6 by nemelo byt nikdy duplicitni
- u hajka se ignoruje zacatek cisla - klient zadava pouze poslednich 5 cifer, pri duplicite se
  matchuje s mailem

==== Rezervace ====
=== Historie objednavek ===
[ ] objednavka by mela mit sloupec pro cas zaplaceni
- updated_at neni spolehlive - muze se zmenit pozdeji
[ ] objednavka by mela mit sloupec pro cas inicializace platby kvuli cisteni bg jobem

=== Ostatni ===
[ ] pridat timezone timestampovym sloupcum
- rails predpoklada, ze casove sloupce bez timezone jsou ulozene v utc, takze automaticky
  prepocitava conditiony v selectech
- pri smazani eventu se smazou registrace, nejspis by melo mit on_delete: :restrict
[ ] optimalizovat db queries - nejspis mame spoustu n + 1 qp

- pri vyprseni session se objednavka nezobrazi v historii
  - co se s ni stane? je smazana uplne, nebo neni closed a proto je odfiltrovana?
    payments#handle v pripade expirace nic nedela, objednavka by tedy mela zustat ve stavu
    payment_initialized, proc se tedy nezobrazuje kosik?

==== Ostatni ====

[ ] pridat monit na makro server, nastavit notifikace
[ ] rozbehnout logstash a sbirat rails logy
[ ] upravit BasicAuth v alto-rails-auth - resi InvalidAuthenticityToken redirectem na
    destroy_user_session_path, ten ale nemuze fungovat, nebot routa je delete, ale redirect delete
    byt nemuze

http://blog.codeship.com/speed-up-activerecord
http://cookieshq.co.uk/posts/how-to-style-emails-with-rails-and-roadie/

https://code.google.com/p/chromium/issues/detail?id=113401
https://groups.google.com/a/chromium.org/forum/#!topic/chromium-discuss/kfsb9V5IPcQ

- chrome zobrazi napravo v adresnim radku varovani, ze zablokoval naky cookies, v show cookies and
  other site data -> blocked se da povolit
- taky se da nastavit v settings (show advanced settings) -> privacy -> content settings -> cookies
  -> manage exceptions
- pote je treba reload (ktery to v prvnim pripade nabidne)
- iframe navic evidentne adresuje server ip adresou, coz bude pusobit blbe
- jak to ale vysvetluje ovo frame, ktery to dela obcas, prestoze zde by zadna session nemela byt

[ ] nastavit X-Frame-Options ALLOW-FROM z konkretnich adres, misto ALLOWALL
[ ] u ovocenky nastavit X-Frame-Options a CSR headery pouze u BalanceControlleru viz
http://jerodsanto.net/2013/12/rails-4-let-specific-actions-be-embedded-as-iframes/

http://www.marinamele.com/taskbuster-django-tutorial
