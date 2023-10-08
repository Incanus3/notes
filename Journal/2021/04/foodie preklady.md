=== foodie - problemy s preklady ===

v src/browser/main.js a src/native/main.js se staticky importuje a registruje slovenska lokalizace
  moment.js (data a casy)
v src/native/polyfillLocales.js se staticky importuje a registruje slovenska locale-data z intl a
  react-intl
v src/common/intl/actions.js je definovan action creator setCurrentLocale, ale z ui se nikde nevola
v src/common/intl/reducer.js je staticky definovane defaultLocale jako 'sk', nerespektuje ani
  LANGUAGE_CODE backendu, ani Employee.language
- zatim upraveno tak, ze defaultLocale se bere z process.env.DEFAULT_LOCALE a fallbackuje na 'sk',
  lze tedy aspon nastavit default jazyk pri kompilaci/spusteni dev serveru

chybejici preklady pro nasledujici retezce (minimalne):
- po rozkliknuti prazdneho stolu - "1. hosť", "Žiadne položky", "Pridať chod"
- pri kliku na platbu - "Potvrdzujú sa položky", "Prebieha platobná operácia"
- platba - "Všetci hostia"

zbyvajici pouziti currency z messages:
- common/components/PaymentSheet:587 - messages.currencySymbol

=== foodie - testy recalculate ===

test_closure_list_printing
- zvazit asertovani tisku na urovni PrintQueue, nikoli redisu
  + zavisime na API, ktere mame pod kontrolou (obecna good-practice, plati primarne v produkcnim
    kodu, ale i tady u testu je sikovne zvazit)
  + testy budou zavisle na volani, ktere by melo byt stabilni (PrintQueue.push) misto volani,
    ktere se muze kdykoli zmenit (misto volani redix.lpush se muzeme v budoucnu rozhodnout volat
    lpushx/rpush/..., uplne vymenit knihovnu, atd.)
  + PrintQueue.push se vola s neserializovanym PrintJobem, ktery se lepe assertuje
  - je pravda, ze v e2e testech tato uprava snizi "hloubku" testu - tedy neotestuje se posledni
    level volani, neni tedy "tak uplne e2e", na druhou stranu, to je soucasne vyhodou (viz druhy
    plus) - kdyby se testovalo, tak se po zmene dependency budou muset zmenit vsechny testy, feature
    testy, ktere na ni narazi
    - je to tedy trade-off mezi "hloubkou" testu a stabilitou, ale v tomto pripade myslim, ze vyhody
      stability velmi vyvazuji drobnou nevyhodu snizeni hloubky, ktera se snadno dozene unit testem
      (mozna uz dokonce je)
