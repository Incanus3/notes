==== foodie-api MR 21 - tests refactor ====

- puvodni myslenkovy pochod
  - `TestCanteen.table` a `sub_table` - pokud stejne muze existovat jen jeden stul a podstul, k cemu
    je dobry atribut `._default_table`, resp. `._default_sub_table`? proc rovnou nepriradit do `.table`?
    - nebo proste mit `default_table` a `default_sub_table` jako public, to by totiz davalo smysl i u
      waitera - tam je to totiz jeste divnejsi - existuje `_default_waiter`, ktery se cte pomoci
      property `waiter`, kterou ale nelze zavolat predtim, nez se zavola `create_default_waiter` (to
      je uz samo o sobe divny - proc ma create_DEFAULT_waiter podminovat volani property waiter - bez
      default) a jeste k tomu existuje `register_waiter`, ale pro stoly a podstoly nic takoveho neni
    - pak by davalo smysl jako `create_default_waiter`, pac odpovida public atributu `default_waiter`,
      tak `register_waiter` pro registraci libovolneho waitera, k tomu bych udelal i odpovidajici
      `register(_sub)_table` a nechal `.default(_sub)_table` public
      - pokud se prida `register_sub_table`, tak je potreba `create_order` pridat volitelny
        `sub_table` parametr (s defaultem na `default_sub_table`)
    - jeste bych se teda zamyslel, jestli neudelat `default_waiter_password` jako volitelny parametr
      pro `TestCanteen.__init__` s defaultem a zbavit se `create_default_waiter` uplne
- vysledek
  - zbavit se uplne default employee
  - nechat vsechny default_... atributy jako public
  - nechat register_waiter, ale parametr waiter bude povinny
  - zbavit se create_default_waiter() - nastavit default_waiter atribut rovnou v konstructoru s tim,
    ze employee a heslo pro waitera se bude brat z (potencialne volitelnych) parametru default_waiter_employee a
    default_waiter_password, s prip. defaulty na urovni classy
  - zbavit se waiter, table a sub_table properties - staci default_... atributy
  - TestCanteen.register_waiter nebude mit vubec prvni radek, bude brat waiter, nikoli employee a
    password, a waiter muze byt jak Waiter, tak TestWaiter

  - Waiter ma smysl i sam o sobe - nemusi nutne vznikat skrze Canteen
  - Canteen.register_waiter slouzi k tomu, aby mu v ramci dane canteen priradila prava
    - bude brat primo instanci Waiter
    - pro pohodlnost muze akceptovat i holou Employee instanci a Waitera z ni udelat a vratit
  - TestCanteen konstruktor bude rovnou brat default_waiter (instance Waiter nebo TestWaiter) a jen ho
    ulozi, heslo ji nezajima

- puvodni myslenka
  - zvazit, zda by pres `TestCanteen` melo byt dostupne `CashRegister` a pripadne i payment media
    - Cateen ma (aktualne private a zmenil bych na public) atribut default_cache_register, ten by mel
      byt dostupny i pres TestCanteen
- vysledek
  - pridat fixtury test_canteen a test_fiscal_canteen, ktere budou vracet instance TestCanteen,
    v testech se bude s register pracovat skrze tyto TestCanteen, tedy
    test_canteen.default_cache_register, apod.
  - Canteen pridat default_cache_register property, tu exposovat i skrze TestCanteen

- puvodni myslenkovy pochod
  - je v poradku, aby CashRegister entity exposovala `food_dat_pk`?
    - bylo by lepsi, aby exposovala primo `food_dat`?
  - nebylo by lepsi mit `CashRegister.def_files` jako property?
    - meni za behem zivota instance? melo by byt memoizovano?
  - https://gitlab.backbone.sk/alto/foodie-api/merge_requests/21/diffs#a84bba3d3e62fee26f88287cfde4f8b8ffde4df0_0_52
    - zde se znova taha z db `FoodDat` record podle `cash_register.food_dat_pk` - sikovnejsi by bylo
      vzit primo `cash_register.food_dat`, pokud nejsou duvody proti
  - volani `CashRegister.add_def_file` kolem
    https://gitlab.backbone.sk/alto/foodie-api/merge_requests/21/diffs#f001b3ca09d0c3df3420aae0c8b65cb13c296929_0_40
    je trochu matouci a navic spoleha, ze klice v dictech vracenych fixturami odpovidaji nazvum parametru add_def_file
- u entity objektu tvorici domain abstrakci nad databazovymi objekty je obecne treba dukladne
  zvazit, jaky budou mit lifespan a s jakymi zmenami db zaznamu tedy maji nebo nemaji pocitat
  - pokusit se navrhnout nejake obecne metodiky na to, kdy pouzit metody a kdy properties
  - videl bych 2 extremy:
    a) domain entita je immutable a jeji data reprezentuji snapshot db v momente vytvoreni
      * vsechny atributy je treba ulozit v konstruktoru
      * lze si predstavit update metodu, ktera bude vracet novou, aktualni instanci
      * zde davaji smysl public atributy, resp. properties, pokud jde o drahy vypocet (ale z jiz
        nactenych dat)
      + jednoduche, dobre se s ni pracuje - netreba zvazovat, co se muze menit pod rukama
      + fieldy se nactou prave jednou
      - je treba z db pri vytvoreni vytahnout i recordy, ktere pro danou instanci nebudou potreba
      - zapisove metody nezapadaji do konceptu - zde dava smysl spis CQRS - separatni write objekty
    b) domain entita je pouze gateway do databaze, atributy jsou vzdy aktualni v okamziku accessu
      * nesmi ukladat zadne ORM instance, pouze id, pomoci kterych pujdou precist
      * zde davaji smysl get_ metody - je z nich jasnejsi, ze se pri kazdem volani cte znovu
      - neni jednoduchy value object, u ktereho lze spolehat na atomicitu - kdyz postupne vytahneme
        dva atributy, nemusi vuci sobe zachovavat integritu
      - pri vice accessech se fieldy nacitaji pokazde znovu
      + nenacita fieldy, ktere nebudou potreba
      + neni problem mit i write metody
  - CashRegister se chova jako podivny hybrid
    - na jednu stranu zpristupnuje def_files zpusobem b, tedy lazy read + write
    - na druhou stranu uklada food_dat, ktery muze byt stale
    - food_dat navic nezpristupnuje, ale pristupuje pres nej k def_files - ve chvili, kdy v db
      food_dat record nekdo smaze, nebo mu zmeni id, dojde k chybe (coz samozrejme plati i ve
      chvili, kdy by ukladala primo pk, ale tam je to aspon explicitni)
    - z toho, jak se zatim CashRegister register pouziva, mam pocit, ze je treba spis objekt typu b,
      tedy GW do databaze; v tu chvili by mela ukladat kas_id, resp. food_dat_pk a naopak definovat
      metodu get_food_dat, ktera pokazde znova precte food_dat z db
    - totez nejspis plati pro EmployeeGroupsManager a v takovem pripade je v poradku metoda
      get_waiters_group, nikoli property
- vysledek
  - CashRegister nebude ukladat FoodDat objekt, pouze pk, ktere bude exposovat skze lepe
    pojmenovanou property
  - zvazit, zda pridat i metodu get_food_dat, protoze muzou byt mista, kde je instance FoodDat potreba,
    aktualne vim akorat o Canteen.register_waiter, kde se z db taha FoodDat podle
    cash_register.food_dat_pk, aby se pote predal cashier_groups.get_or_create jako kas, to by ale
    slo vyresit tak, ze se preda pouze food_dat_pk jako kas_id, zatim tedy nejspis neexposovat

- https://gitlab.backbone.sk/alto/foodie-api/merge_requests/21/diffs#a84bba3d3e62fee26f88287cfde4f8b8ffde4df0_0_61
  - `EmployeeGroupsManager` trida vs `Canteen._employee_group_manager` atribut - bud bych mel group
    v obou pripadech v singularu, nebo v pluralu - zalezi, zda jedna instance managera managuje
    jednu grupu, nebo vic

- `EmployeeGroupsManager.get_waiters_group` - property?
  - podobna uvaha jako `CashRegister.def_files`
  - nakonec ne - EmployeeGroupsManager bude stejne jako CashRegister entita typu b a tudiz bude mit
    explicitni get metody, ktere budou pokazde fetchovat nanovo
