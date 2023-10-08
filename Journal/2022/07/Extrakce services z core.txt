=== extrakce services z core:models ===

- je problematicka, protoze:
  - auditing zavisi na workflow (a naopak)
  - workflow zavisi na Address (a naopak)
  - na Address ale taky zavisi spousta zakladnich core:models veci (napr. Artifact)
    - to by se dalo vyresit rozdelenim Address builderu - samotna Address a zakladni buildery
      zustanou v core:models, specificke workflow buildery pujdou do core:services
  - krom toho ale zakladni veci v core:models (primarne Artifact) zavisi na Repository a repository
    zavisi na vsech ctyrech zakladnich servicach - logging, workflow, nominations a access control
  - tenhle problem ma dve slozky:
    - v kompozici by mely byt typicky vazby jen jednim smerem - bud by mel mit reference agregat na
      svoje casti, nebo child na parenta (typicke u stromovych struktur)
      - tady jsou ovsem vazby obema smery:
        - registr vi o svych artefaktech, ale ty taky vedi o registru, do ktereho patri
        - repository vi o spravovanych registrech, ale registr ma taky vazbu na repository
      - diky tomu nelze od sebe tyto casti rozumne oddelit do ruznych modulu, protoze jsou kompletne
        provazane
      - to ovsem ve skutecnosti neni tak hrozne, nebot by se dalo rict, ze vsechny (za podminek, ze
        repository pouze spravuje registry) patri mezi zakladni modely (modul core:models)
    - druhy a z meho pohledu zavaznejsi problem je, ze Repository krome spravy registru a manageru
      poskytuje jeste zminene ctyri servicy (ktere by v core:models byt nemely) a celkove toho dela
      hrozne moc (spravuje jeste data story, usery, persony a workflow transitiony), cimz hrube
      narusuje Single responsibility principle. jde proste o klasicky God object
      - extrakce techto dodatecnych zodpovednosti z Repository by pomohla jak v reseni aktualniho
        problemu vytazeni nepatricnych veci z core:models, tak obecnemu navrhu qwazaru
      - co se zminenych servic tyce, jsou tu dve relativne samostatne - logging a workflow
        (pominu-li, ze i pri praci s workflow artefaktu se resi securita) a pak dve, ktere se
        vylozene tykaji security - nominations a access control
      - securitu by obecne bylo zahodno predesignovat tak, aby
        - jeji konfigurace byla prakticka (jasne definovany zpusoby, kterym se jeji jednotlive
          slozky nastavuji) a soucasne dostatecne flexibilni
        - byla rozumne navrzena tak, aby umela pokryt vsechny potrebne use-casy (napr. vcetne
          lokalnich nominaci artefaktu), ale soucasne o ni zakladni modely (primarne Artifact)
          nemusely vedet

=== extrakce security z backend-apps:generic ===
- ModuleSecurityServiceImpl zavisi na ViewSetRegistry, RegistryRouter, RegistryViewSet a
  URL_REGISTERS_SLOTUPDATE_BATCH
  - ty by se daly vyextrahovat do samostatnych backend-apps modulu - rendering (views a reports) a
    registries
  - otazka ale je, jestli nebudou mit zavislosti i opacnym smerem na securitu
- DevelopmentSecurityDataLoader
  - vytvari skupiny a uzivatele pro starou EA-based securitu
  - presunuto do ea:db, kde jsou i repositare, se kterymi pracuje
  - pouziva ale konstantu ModuleSecurityService.QWAZAR_ADMIN

=== extrakce renderingu z backend-apps:generic ===
- ViewSerializationService a serializery formovych search inputu a neformovych select a search
  inputu zavisi na RegistryRouteru
  - RegistryRouter ale bylo v planu dat do backend-apps:registries, ktery bude zaviset na
    backend-apps:rendering, protoze bude krom jineho definovat RegistryViewSet
  - zavislost by ale teoreticky mohla byt opacne, pokud v registries nebude zadna zavislost na
    renderingu
  - zatim vyreseno tak
- ActionWithGid a RedirectSerializer zavisi na ReportRouteru
  - podobna situace - v planu bylo, ze pribyde modul backend-apps:reports, ktery bude mit zavislost
    na renderingu
  - zde ovsem zavislost nejspis otocit nepujde, protoze reporty budou zcela urcite potrebovat
    rendering - potvrzeno
- predchozi dve veci ukazuji na sirsi problem - runze veci v renderingu (a mozna i jinde) napr.
  akce s requesty (ktere jsou samy o sobe obecne a mohou byt tudiz takhle nizko) ted jsou zodpovedne
  za prevod akce na request, pricemz znaji ActionTypy, specificke Routery (RegistryRouter,
  ReportRouter, getTriggerTransitionUrl) a konkretni zpusoby jejich volani
  - tyto typy akci, resp. endpointu, ktere je obsluhuji, jsou ale poskytovany jinymi castmi
    aplikace, o kterych by rendering vedet nemel, a ve vyse uvedenych pripadech ani nemuze, protoze
    to vede k cyklickym zavislostem
  - chybi tu totiz nejaky obecny koncept routeru, ktery by obecnym zpusobem prevadel pozadavky
    (nejspis tedy Actions) na requesty/redirecty/urlka
  - ono uz to, ze konkretni ActionTypes (create artifact, trigger event, trigger wf transition, run
    report) jsou definovany uz na teto urovni (resp. dokonce v uplne nejcorovejsim modulu -
    core:models) je spatne, protoze ten o techto funkcionalitach nema vubec nic vedet
  - ActionType by tudiz nemel byt konecny vycet definovany uz takhle nizko, ale otevreny vycet
    (interface? value class?), do ktereho mohou vyssi casti aplikace pridavat a spolu s tim pridavat
    pravidla pro routing techto akci
    - jeste je potreba zjistit, co vsechno na ActionType aktualne zavisi, pokud ale neco v core
      zavisi na konkretnich ActionTypes, je to spatne
  - routing by se mohl konfigurovat podobne, jako se definuji pravidla security - Router by mel
    funkce pro registraci pravidel a bylo by mozne nad nim definovat extension funkce pro
    konfiguraci routingu pro jednotlive moduly. ty by se pak volaly z nejake vetsi konfigurace
    - pravidla by mohla mit dve slozky - matcher na akci, podle ktereho se pozna, zda pravidlo akci
      obslouzi, a samotna prevodni funkce z akce na request/url/redirect
    - vzhledem k tomu, ze ale matcher bude velmi pravdepodobne testovat, zda je akce instanci nejake
      tridy, bylo by sikovnejsi, spojit dohromady, at se nemusi znova castovat v prevodniku - byla
      by tedy jen jedna funkce, ktera by bud umela akci oblslouzit a vratila by vysledek, nebo
      neumela a vratila by null
  - krome toho be mel Router samozrejme cteci metody - nejspis urlFor, requestFor, redirectFor,
    ktere by nejspis braly action
  - nevyhoda tohoto pristupu je, ze krome pridani gradle zavisloti na modulu a pridani jim
    poskytovanych trid (typicky controlleru/routeru a handleru) do kontextu, je treba jeste zavolat
    funkce pro konfiguraci routingu
    - to by na druhou stranu nemusel byt takovy problem - modul by mohl poskytovat konfiguracni
      tridu, ktera by 1) importovala vsechny komponenty, ktere modul poskytuje a 2) konfigurovala
      routing a pripadne dalsi veci
  - router by se pak pridal do renderovaciho a serializacniho kontextu a sestaveni requestu k akci
    by se delo na urovni serializeru (ktery ma k serializacnimu kontextu pristup)
  - moduly by navic mohli nad Routerem definovat dalsi extension metody pro pohodlnou praci s nim,
    ty by nahradily metody aktualniho RegistryRouteru, ReportRouteru + funkce jako
    getTriggerTransitionUrl
- ReportRunner pochopitelne zavisi na ReportMetadata, stejny problem jako vyse
- DataTable serializery potrebuji ResourceAwareViewSerializationContext, ktery ale zatim nejde dat
  do renderingu, protoze zavisi na json api
  - to je ale predpokladatelne, nejspis pribyde nejaky modul backend-apps:integration, ktery bude
    mit zavislosti na zbytku a bude je spojovat dohoromady, tam pak bude jak
    ResourceAwareViewSerializationContext, tak data table vcetne jeji serializace
- totez plati pro two step

=== TODO ===
- otestovat AIMatrix event - BIA - ohodnocení činností - tlačítko: Detail u nějaké činnosti
  - nefunguje, protoze refreshe se na backendu presunuly z buttonu do action, ale frontend s tim
    jeste nepocita, to uz je ale rozbite od merge "add RestTableActionWithInputs"
  - zatim opraveno docasnym fixem
- odstranit zbytecne zavislosti
  - zamyslet se nad tim, jak ma byt resena TestRestPersistenceConfiguration - je v
    backend-apps:base, ale vi o db entitach z json-api, auditingu a security, soucasne ale
    prekvapive funguje, i kdyz jsou u auditTrace a nominations stare package
- prejmenovat vsude logging na auditing

=== pro petra ===
- opravit validacni button v bie

{
  "type": "single"
  "label": "test",
  "icon": "car",
  "style": "outline",
  "variant": "primary",
  "action": {
    "type": "NULL_ACTION",
    "params": {},
    "includeRows": "selected",
    "selectedRowsParamName": "selectedRows"
  }
}

{
  "type": "single-with-inputs"
  "label": "test",
  "icon": "car",
  "style": "outline",
  "variant": "primary",
  "action": {
    "type": "NULL_ACTION",
    "params": {},
    "includeRows": "selected",
    "selectedRowsParamName": "selectedRows"
  }
  "inputs": [...],
}

{
  "type": "group",
  "label": "some group",
  "icon": "car",
  "style": "outline",
  "variant": "primary",
  "actions": [
    {
      "label": "action1",
      "action": {
        "type": "NULL_ACTION",
        "params": {},
        "includeRows": "selected",
        "selectedRowsParamName": "selectedRows"
      }
    }
  ]
}
