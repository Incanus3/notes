=== update frontendu ===

[x] doresit problem s nacitanim z libu
[x] rozbehnout produkcni build
- upravit nastaveni minifikace, aby se nemanglovaly nazvy

[x] projit, upravit a popushovat generovane js v knihovnach
  [ ] zkontrolovat, ze nevznikly chyby pouzitim && tak, ze se snazime renderovat false
[x] vytvorit novou vetev v kreditu, prepsat vse new-kreditem a pushnout

[x] projit importy a pridat do zavislosti projektu ty, ktere se primo v projektu pouzivaji
- aktualne nektere chybi (napr. react-router), ale funguje to, protoze se natahly se zavislostmi
- chybejici importy:
  - prop-types - urcite pridat
  - bootstrap-sass - urcite pridat
  - react-bootstrap - urcite pridat
  - react-router{,-dom} - urcite pridat
  - react-widgets - importujeme pouze styly
  - react-app-polyfill - kdyz pridame, hrozi, ze se rozejde s verzi, na kterou zavisi react-scripts

[x] aktualizovat react-widgets na verzi 5
  [x] po updatu se rozpadne stylovani DatePickeru, kdyz je obsazen v headeru tabulky
  [x] otestovat a prip. opravit ClientSelect
  [x] otestovat a prip. opravit registration/LoginCredentialsWithBV

[x] doresit globalize, resp. cldr-data
- nakonec asi netreba resit - react-widgets 5 uz globalize nepodporuji a maji preddefinovanou
  lokalizaci, zaktualizovat tedy ty
- prozatim pridan globalize-webpack-plugin, nebot aktualni CRA porad jeste pouziva 4kovy webpack

[x] aktualizovat vsechny zavislosti
- chybi pouze react-bootstrap

[x] zbavit se vsech "decaffeinate suggestions"
[x] zbavit se vsude _.assign
[x] zbavit se vsech <React.Fragment>

[x] opravit boolean select (napr. administrace chodu - "je doplnkovy")
[x] importovat vsechno z react-router-dom, zbavit se prime zavislosti na react-router

[x] zbavit se componentWillMount
[x] zbavit se componentWillReceiveProps
[x] prepsat praci s kontextem na nove api
[ ] prepsat refy na nove api

[ ] zbavit se request-promise
[ ] prejit na lodash-es - melo by mit lepsi tree-shaking

[ ] vyresit co nejvic (idealne vsechny) warningu
- runaway promises
  - pri prepisu do js odstranujeme vsude mozne puvodni `return null`, ktere tam byly kvuli runaway
    promisum
  - nemelo by to vadit, protoze js narozdil od coffee nema implicitni return, takze pokud
    nereturnujeme explicitne, vrati se undefined
  - je to ale otazka, zda na signalizaci neni skutecne potreba `null`
[ ] upgradovat na novy bootstrap
[ ] vyzkouset, jestli uz nezacalo fungovat nacitani historie transakci pres custom routu
- alto-react-kredit/lib/components/transaction_history/main:115
- pokud jo, zbavit se rules, ktere dovoluji cist vlastni transakce pres crud routy

[ ] otestovat odhlaseni z duvodu neaktivity po upgradu react-idle-timer
[ ] otestovat password reset
[ ] otestovat resend activation email
[ ] otestovat datesInInterval a currentLocation po zmenach
[ ] idealne napsat unit testy na utils
[ ] otestovat TimeInput
  - time picker se nejspis pouziva v administraci chodu
[ ] otestovat management terminalu
[ ] otestovat terminal login
[ ] otestovat on-screen-keyboard
  [ ] odkomentovat import ceskeho rozlozeni klavesnice a vyresit problem s undefined jQuery.keyboard
  - zjistit, kde se definuje
    - v kompilatech knihoven se hleda extremne blbe - podivat se na zdrojaky pred kompilaci
  - mozna nebude treba - react-keyboard verze 1.30.0 pridava cesky preklad, tak zkusit pouzit ten
  - zvazit prechod na react-simple-keyboard - react-virtual-keyboard ma posledni release pred 3 roky

[ ] aktualizovat bakare
  [ ] otestovat recaptchu po upgradu uuid
createSetting('auth.login.recaptcha', { enabled: true, site_key: '6Ld5zUkUAAAAAIA-j0HmtRPVNzMl63gOmGJdk1vx' })
