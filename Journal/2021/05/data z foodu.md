=== instalace foodie ===
- EKK doresi inteligentni append ssh configu
- EKK doresi inteligentni append do known_hosts
- klonovat backend z SK gitlabu
  - upravit davku s git clone
  - upravit ssh config
  - pridat deploy@win klic do SK gitlabu - vyreseno
- opravit food_kuba databazi, aby se nad ni daly pustit migrace
  - idealne dropnout cele public schema a vytvorit znova migracemi plus prevodni procedurou
  - pred datastore/0003 migraci byla predsunuta nejaka cookova a zbytek prejmenovan o cislo vys
    - zatim prejmenovano rucne v db a funguje
- doresit posilani LANGUAGE_CODE na frontend
  - v development settingu neprepisovat LANGUAGE_CODE staticky na SK
  - po nastaveni employee.language_code na null zmizely stoly
    - v db zadne stoly (OpenTables) nejsou, takze se evidentne bere z table definitions, ale jen
      pokud maji employes nastaveny language na sk-SK (nebo mozna na nejaky, ktery odpovida necemu
      nekde jinde)
    - common/components/Table ma guard, ktery vyrenderuje pouze, pokud je state.auth.user, ktery je
      v tomto pripade null, odkud se bere?
    - pri SIGN_IN_DONE se nastavi na object s id a tokenem, pak se ale z nejakeho duvodu zavola
      jeste AUTH_RESET, ktery nastavi zpatky na null
    - AUTH_RESET se vola v onVisit hooku LoginPage
    - LoginPage se po prihlaseni vola onVisit LoginPage jeste jednou po SET_INTL akci
      serviceArea
    - redirect po loginu je resen v src/browser/auth/redirectAfterSignIn a probiha dvoukolove
      - pri akci APP_STARTED nebo SIGN_IN_DONE se nastavi willNeedRedirect na true
      - pokud je willNeedRedirect true, tak se pri akci BLITZ_SYNC_SERVER_DATA_COMMIT nebo
        SYNC_SERVER_DATA_COMMIT nastavi na false a redirectne se na /serviceAreas
    - redirect na / se dela
      - v AllowedRoute pro /serviceAreas pokud neni servicearea.read permission, coz ale je
      - v browser/device/Form submitu, ten se ale nevola
      - v signOutOnInactivity, ten se ale nevola
    - nezda se tedy, ze by se nekde redirectovalo (ani @@router/LOCATION_CHANGE se nevypisuje)
    - proc se tedy kurva vola vickrat onVisit hook LoginPage?!
  - vyzkouset ve vetvi feature/sync
- v ramci foodie FE CI udelat build a nekam nakopirovat, odkud pak budou davky stahovat

=== konverze dat z foodu do foodie ===

- pridan zaznam do food_dat
  - pgm=KAS, pgm_param=SLAVE,
  - master_kas, id_master, idmaster?
  - id_klapky?
- pridany zaznamy do miestnosti a miestnostikukase

=== s milankovymi daty ===

- je potreba recreate
  - je potreba presunout price_levels_food.sql z 0_exclude do 1_tables
- pri volani _ad_food_danube
  - pada pri insertu do items na tom, ze sloupec is_deleted je not-null
  - do insertu je potreba pridat false do is_deleted
- v datech neni naplneno ug___
- neni naplneno gr___
  - prozatim vyreseno nastavenim employee.is_superuser = true
  - zvlastni je, ze se nenastavi automaticky, kdyz je v food600.users is_admin = 1
- neni nastaveno druhy_pl

=== procedura _ad_food_danube ===

- procedura ve foodie je (bud ji vytvoril food, nebo vznikla migracemi - zjistit)
- podminene se vola _danube_import_truncate a ta uz v db neni
- z defsubor presouvaji (update or insert) zaznamy do danube_configuration
  - vola se ale procedura _varval, ktera neni
- z defsubor se vezmou zaznamy s var_name = 'oblast_[abc]', vezme se posledni z nich, ktery ma
  var_value (datum) v minulosti, podle toho se nastavi oblast (pouzije se pri sestavovani selectu z
  food_datu a pri insertu do _klapky) a lv_oblast (pouzije se na filtrovani food600.klapkyn)
- public._food_items (nejspis docasna tabulka)
- sestavi se select sloupcu '<oblast>[1-9]' z food_datu pro pgm='KAS'
- do _food_items se insertuje z joinu food600.scennikspart a food600.karty

=== db struktury ===
== tiskarny ==

- primarni seznam vsech tiskaren je v prn_def
- kasa_ucp definuje, ktere tiskarny se pouzivaji na kasach
  - master_id referencuje food_dat.id master kasy
  - id referencuje food_dat.id konkretni kasy
  - ucet_no referencuje prn_def.prn_no
- kasa_set definuje (krom jineho), ktere tiskarny se pouzivaji na uzaverky
  - master_id referencuje food_dat.id master kasy
  - uzav_no referencuje prn_def.prn_no
