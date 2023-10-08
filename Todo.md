====== Todo ======

[ ] **ZAKTIVIZOVAT SE**
  - na praci pro emailmachine se velmi tesim, bude to zmena k lepsimu ve vetsine
    veci, co me na aktualni praci nebavi
    - pocit, ze moji praci nekdo pouziva
    - tymova spoluprace a kazdodenni feedback
    - jeden projekt, nikoli skakani od jednoho k druhemu
    - nove, zajimave technologie a problemy (napr. optimalizace vykonu na mnoha
      urovnich - maily, db, neo4j, komunikace s externimi sluzbami,
      import/export)
    pro jeji rozumne zapoceti je ale treba co nejdriv dokoncit stavajici veci

[ ] sestrojit poradny prioritizovany TODO list, granularizovat prubezne pri
    praci
[ ] v kazdou chvili presne vedet co delam, ceho se snazim dosahnout a jaky je
    prvni dalsi krok

[ ] napsat emaily do emailmachine
- p. Koupilovi
  - neprakticke veci:
    - prekryvani asociaci, jak uz jsem zminoval (najit v historii)
    - pouzivani slovnich logickych operatoru (and, or) misto znakovych
    - naduzivani hooku v modelech, napr. ContactList je absolutne
      netestovatelny, nebot after_create okamzite importuje kontakty - zavisle
      na existenci xml souboru a take na externich sluzbach (neo4j, mozna rest
      api)
    - validace MX recordu adresy v modelu (netestovatelne, enormne pomale, delat
      vne modelu - v service nebo controlleru, tak aby bylo mozno vytvorit
      testovaci Campaign s neexistujici adresou)
- p. Schejbalovi
  - predstavit se
  - popsat predstavu o prvotnim zapojeni se
    - preposlat report, ktery jsem posilal p. Koupilovi, zminit se o dalsich
      problemech, prip. dalsich pozorovanich
  - shrnout veci, se kterymi bych potreboval v prve rade pomoci
    - rozbehnuti torqueboxu
    - informace o tom, jak vypada proces
    - popsat sve zkusenosti a vnimane slabiny
      + dobry objektovy navhr pro snadnou spravovatelnost a flexibilitu
      + zkusenosti s TDD
      * uvest konkretni zkusenosti, ktere by se nam mohly hodit, prip. konkretni
        nastroje, zminit napr. scientist pouzitelny pri mergi featur, volby
        jruby pro zrychleni jeho startu (testy)
      - zkusenosti s procesem, tymovou spolupraci
      - zkusenosti s front-endem
      - zkusenosti s jruby a souvisejicimi technologiemi (torquebox, jboss, java)
  - vymenit si kontakty, idealne jabber

==== FriendlySystems ====

[ ] zjistit, zda se lze pomoci roundcube autentifikovat proti imapu (nikoli proti
    db) a jak je to pak s daty, ktera ukladaji pluginy
- roundcube dokumentace je dost mizerna
- defaultni authentikace je nejspis proti imap serveru, coz by znamenalo, ze pro
  login neni potreba vic, nez aby byl vytvoren ucet na mailserveru, bylo by ale
  treba vyzkouset, coz muze byt dost casove narocne (vzhledem k mym minimalnim
  znalostem ohledne mailserveru)

[ ] otestovat vsechny akce decommissions
- mass_index [ ]
- mass_decommission [ ]
- show [ ]
- index [ ]
- new [ ] [*]
- edit [ ] [ ] [ ]
- create [*]
- update [*]
- destroy
- approve [ ] [*]
- take_back [*]

[ ] opravit link_to_remote a link_to_function volani
[ ] opravit vyhledavani

==== Alto ====

[ ] odsouhlasit obchodni podminky
  - jak udelat cteni podminek? odkaz na stranku s podminkami znamena vyprazdneni
    formulare po navraceni - idealne otevrit modal nebo dalsi tab)
  - jak udelat overeni? potrebujeme checkbox, ktery nebude volat metodu na form
    object a bud vyrenderovat znova new, nebo overit javascriptem
  [*] zobrazit input, ktery nevola metodu na objekt
  [ ] nastavit default na false
    - optiony predane form.input se do parametru options metody
      FakeCheckboxInput#input nedostanou - projit kod a zjistit, jak se daji
      odchytit
    - tato metoda ale nedokaze obarvit checkbox pri nezaskrtnuti
  [ ] overit v akci a renderovat new, pokud nevyplneno

- zvážit předělání registračního formuláře a případně toho na úpravu profilu na
  form objecty
  + není problem s virtuálními fieldy
  + zjednoduší se validace v modelu, je to ale k dobru?
    - validace na jedné úrovni bude jendodušší, ale pak bude muset form
      vědět, že má modelu předat vnořené parametry v hashi
    - pokud zůstanou některé validace v modelech, sníží se kolokace, navíc bude
      třeba kopírovat validační errory
    - validace jsou několika typů
      - typ a formát dat - nejspíš nechat v modelu
      - unikátnost - ani mimo model být nemůže
      - bezpečnost - ověření hesla - ideálně extrahovat
      - přítomnost atributu
        - pokud jsou data bez atributu nekonzistentní, pak nechat v modelu
        - pokud vyžaduje nějaká politika, pak nejspíš extrahovat
  + vyčistí se view
    - nebude třeba vnořování, pouze pro markup
      - znalost vnořování fieldů je na mnoha úrovních (případné změny je tedy
        nutno provádět na mnoha místech)
        - view musí vnořeně zobrazit
        - form musí vnořeně předat modelům
        - model musí serializovat
          - poslední dvě by bylo lze sjednotit, pokud by model bral lineární hash
            a vnoření by vyřešil sám, to ale může být velmi složité
    - nebudou potřeba hacky na virtuální fieldy

- co by obnášelo?
  - view má lineární objekt pro form_for, musí vnořovat akorát markup panelů
  - form object musí mít readery pro všechny fieldy a musí jít inicializovat z
    params (při opětovném vykreslení)
    - duplikuje znalosti modelu - změna na více místech
    - použít virtus?
      - poskytuje definici atributů s případnou koercí a inicializaci z hashe
      - lze includovat Validations a přenést validace z modelů
      - nebo extrahovat validace do samostatných objektů, které bude možno
        kombinovat?
      - povinné fieldy jsou navíc duplikovány v kontextech
        - měl by být jeden objekt, který by znal povinné fieldy a tuto znalost
          by poskytoval view a validatorum
    - co by měly formy pro registraci a editaci profilu společného a co
      odlišného?
      - atributy a validace jsou nejspíš velmi podobné
      - jiné je uložení recordů
        - je to ale skutečně zodpovědnost form objectu?
        - čím se liší create a update akce, co by přišlo do form objectu?

[ ] opravit migrace v objednavkach tak, aby fungovala bigintova id

- Praha - ctvrtek 8.15 z olomouce
