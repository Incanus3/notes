=== kde volat? ===

- idealni by bylo z manager.save() nebo entity.save()
  - jak jsou implementovane?
    - manager.save():
      - InMemoryManager
        - pouze ulozi entitu do memory
        - entity.save() se nevola z manager.save(), ale z update()
      - DbArtifactManager
        - zavola dbRepository.save() s dbEntitou
        - entity.save() se nevola vubec
      - EaObjectManager:
        - dela spoustu veci specifickych pro EA, krom jineho ulozi eaObject, referenci, package
        - prochazi sloty z shape a pokud jsou dirty, zavola saveSlotValue, ktery podle
          slot.source.type zavola specifickou EA metodu pro save
        - entity.save() se nevola z manager.save(), ale z update()
      - zadna z nich nevola primo zadnou save() metodu na slot
        - sloty totiz samy nevedi, jak se savuji
      - to ale neznamena, ze by nemohly pribyt metody na before/after save
    - entity.save():
      - vzdycky vola manager.save()
  - odkud se volaji?
    - entity.save():
      - z klientskeho kodu
      - z backend-apps (coz je z pohledu tehle vrstvy taky "klientsky" kod)
      - z Manager.create()
      - z InMemory(Relation)Manager.update()
      - z EaConnectionManager.create()
      - z Ea(Object|Connection)Manager.update()
      - tohle je dost nekonsistentni - nejspis be se mel volat z create() a update() vsech manageru,
        nebo zadnych - volat primo na manager
    - manager.save():
      - z klientskeho kodu
      - z backend-apps (coz je z pohledu tehle vrstvy taky "klientsky" kod)
      - z Entity.save()
      - z Registry.save()
      - z InMemoryRelationManager.createConnection()
      - z RepositoryImpl.save()
      - z DatabaseArtifactManager.update()
  - TODO: entity.save() by se IMHO mela idealne volat pouze z klientskeho (a backend-apps) kodu pro jeho
    pohodlnost (aby nemusel pracovat s manazerem), ze zbytku mist (minimalne tech, co maji manazer
    rovnou k dispozici) by se melo volat na manageru
- jake jsou dalsi varianty?
  - manager.update() - to muze byt pohodlnejsi, ale nemyslim si, ze to je dobry napad - callbacky by
    se mely volat konzistentne, at uz se vola manager.update(), nebo se na entite nastavi sloty a
    zavola se na ni save(), coz je typicky zpusob, jak vola klientsky kod (krome RegistryController.update)
  - nejspis tedy nic rozumneho, rozhodovani je tedy mezi manager.save() a entity.save()
    - hezci by mi prislo entity.save(), ale mozna je manager.save() lepsi - ten totiz primarne
      pracuje se sloty entity, ona sama o nich moc nevi (krom toho, ze implementuje get() a set())
    - kazdopadne je ale potreba zajistit, aby se zavolalo vzdycky - at uz se zvenci vola
      entity.save(), nebo manager.save()
    - nejspis to musi byt manager.save():
      - kdyby se vztah entity.save() a manager.save() otocil - manager.save() by volalo
        entity.save() a ne naopak, neprovedl by se pri volani entity.save() vsechen potrebny kod -
        manager.save() totiz dela nadmnozinu logiky entity.save()

=== kdy volat? ===

- idealni by bylo volat jen pokud je slot dirty, ne vsechny typy slotu ale dirty podporuji (mozna by
  mely)
  - dirty, spolu s initialized, internalValue, stringValue a source (ten je vylozene EA-specific)
    jsou definovany na EaSlotu
  - zbytek ma ale nejspis smysl resit az lokalne

=== TODO ===

- rozsirit podporu dirty do vsech slotu - hotovo
- zajistit, aby se bud entity.save() nebo manager.save() volalo ve vsech pripadech - at uz se zvenci
  zavola kterakoli z nich
  - pro manager.save() uz je nejspis zajisteno, nebot vsechny implementace entity.save() deleguji na
    manager.save()
  - to je nejspis dalsi duvod, proc je manager.save() sikovnejsi misto pro volani - ten je totiz
    hlavne za savovani zodpovedny, entity.save() je jen pro pohodlnost
- sjednotit volani entity. a manager.save() z ruznych manageru
- pridat do slotu atributy pro callbacky + builder metody, ktere je nastavi
- zavolat callbacky a otestovat pro vsechny relevantni varianty

=== refactor dirty trackingu ===

- odkud se k `dirty` atributu pristupuje?
  - cteni:
    - EaObjectManager.save() testuje pred volanim saveSlotValue
    - EaConnectionManager.saveSlot() testuje pred volanim saveSlotValue
    - proc se vola v kazdem jinde?
  - zapis:
    - Ea(Object|Connection)Manager.saveSlotValue nastavuje na false
    - Ea(Object|Connection)Manager.update nastavuje na true
    - metoda setValue() vsech EA slotu nastavuje na true
      - vsechny EA sloty maji metody getValue a setValue, ktere ale nejsou v zadne nadrazene tride a
        nevolaji se (alespon i EaFlotSlotu) interne, odkud se vola?
        - tohle jsou standardni metody, ktere musi implementovat kotlini property delegate
        - i tak by ale bylo sikovny, aby byly deklarovany na urovni SlotDelegate, je s tim problem?
          - problem je s typem ownera - ruzne sloty podporuji ruzne typy ownera
          - to by se ale dalo resit tak, ze sloty budou genericke i v typu ownera, coz by nemuselo
            byt od veci, hrozi ale, ze se zase typove parametry rozsiri vsude

== jak se bude volat? ==

- sikovne by bylo, kdyby se volani callbacku resilo primo z entity, aby nemusel resit kazdy manazer zvlast
- nemuze to ale resit primo entity.save(), protoze ta se ne vzdy vola a manager.save() ji ani volat
  nemuze, protoze je soucasne potreba, aby entity.save() volalo manager.save(), tudiz by bylo cyklicke
- entity.save() by mohlo resit jedine ve chvili, kdyby se manager.save() vzdycky volal skrze
  entity.save(), nikdy naprimo
  - vsechen kod by tedy volal entity.save(), ta by obslouzila before-save callbacky, pak by zavolala
    manager.save() a pak by obslouzila after-save callbacky
  - to by bylo uplne idealni, ale je otazka, jestli je to realizovatelne


- badge - 9.45-10.45 = 1h
- site - 11-13 = 2h
- report log - 14.00-14.45 = 45m
- app log - 14.45-15.45 = 1h
- eventy - 15.45-16.15 30m
= 5h15

- form id = entityGid-widgetType-position
- input id = entityGid-fieldName-widgetType-position


{
  "widgetType":"modal",
  "lid":"some-container-0",
  "variant":"DEFAULT",
  "cssClass":"",
  "cssStyle":"",
  "title": "Some awesome title",
  "body": {
    "widgetType": "whatever", ...
  }
  "footer": {
    "widgetType": "whatever", ...
  }
}
