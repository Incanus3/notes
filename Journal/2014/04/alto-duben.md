==== Soucet ====

3+4+3+6.5+4+1.5+9+3+6+5.5+7+7.5+6.5+6 = 72.5

=== Tue, 1.4. ===

- prace - alto
  - 10-11
    - added javascript to submit canteen selection once the value is selected
    - current canteen is no longer shown above the selector since the selected
      value is always the current one
    - instead a span with data attributes of canteen and chain was added
    - updated ClientAuth to allow current_canteen, _chain and _policy as helpers
    - updated specs
  = 1h

=== Wed, 2.4. ===

- prace - alto
  - 7.15-8
    - SinglePortionController now sets ordered_from to request ip when ordering
      from web
      - tested in controller spec
    - SessionsController now finds user by client_id instead of email
  - 8-8.15
    - MultiplePortionController now sets ordered_from to request ip when
      ordering from web
      - tested in controller spec
    - shared examples moved to dedicated folder so that they can be split to
      multiple files
  = 1h

=== Thu, 3.4. ===

- prace - alto
  - 1-2
    - client now has proper error message when associated user couldn't be
      created
      - added custom validation
      - added translation for user attribute and error message
      - tested in Client::Create service spec
  = 1h

=== Wed, 16.4. ===

- prace - alto
  - 4h - studium JavaScript, CoffeeScript

=== Thu, 17.4. ===

- prace - alto
  - 5-6.30
    - snaha o upgrade railsu na 4.1, ale problemy se stack overflow

  - 9-9.30
    - aktualizace aktualit a aplikace na serveru

  - 1-2
    - added failing spec for log in by card with indirect relation
    - marked need for extraction of canteen relation logic from client model

    - added notes for extraction of relation logic from client
  = 3h

=== Sat, 19.4. ===

- prace - alto
  - 5.30-6, 6.15-6.45
    split client_firma_join in two tables - client_jidlena_join and
      client_retezec_join
    - added migrations
    - ClientCompany is now abstract class
    - removed default scopes from ClientCanteen and ClientChain, querying is no
      much more efficient
    ClientRelationsController#remove_relation is now handled by two actions -
      remove_canteen and remove_chain
    - updated routes
    - updated specs

  - 6.45-7, 7.30-7.45
    - vymysleni Client::Relation API

  - 7.45-9
    extracted presentation logic from Client::Relation to RelationPresenter
    - used in CurrentCanteenController, ClientsHelper, canteen_selector
    - updated specs
    updated notes about new Client::Relation API

  - 9-9.30
    - analyza queries pri nacteni single portion menu

  - 9.30-10
    MenusController loads all meals in one query

  - 10-10.30
    extracted relation-finding logic from Client
      to Client::Relation
    - updated ClientAuth and SessionsController
    - updated specs

  - 11.30-11.45
    renamed Client::Relation to ClientCanteenRelation
    - updated ClientAuth, StoredRelation, SessionsController
    - updated specs

  - 11.45-12.15,1.30-2
    started implementing login by card for indirect
      relation between client and canteen (disabled for now)
    - Client#add_canteen_relation and #add_chain_relation now uses
      find_or_create_by! instead of create
    - added Chain#add_canteen (uses find_or_create_by!)
    - added ClientCanteenRelation#create which creates direct or indirect relation
      depending on whether chain was supplied
    - wrap_attribute no longer hides the original attribute since this makes
      create not work with direct column specification, making find_or_create_by
      unusable
    - updated specs

  - 2.30-2.45
    tested Client#add_canteen_relation and #add_chain_relation
    - they now raise RelationWithDifferentTypeExists appropriately

  - 2.45-3
    tested Client#remove_canteen_relation and #remove_chain_relation
    - they now raise RelationDoesNotExist appropriately

  - 3-3.30
    - tried other edge cases when using add_canteen|chain_relation, added notes

  = 6h30

=== Sun, 20.4. ===

- prace - alto
  - 2h - reseni bugu v Rails
    - ActiveRecord.find_by raises StatementInvalid - no such column <assoc name>
      when given non-AR param as association - should be fixed in upstream

    class User < ActiveRecord::Base
      belongs_to :client
    end

    Client.find_by(client: nil)

  - 2h - analyza queries pri nacteni menu
    - uzivatel - v user podle id v session
    - klient - v client podle user.client_id
    - direct_canteen_relations klienta
      - prime vztahy - v client_jidelna_join podle id klienta
      - jidelny - ve firma podle firma_key vztahu (zbytecny where na vyber jidelen)
    - indirect_canteen_relations klienta
      - vztahy s retezci - v client_retezec_join podle id klienta
      - retezce - ve firma podle firma_key vztahu (zbytecny where na vyber retezcu) - k cemu je vubec tenhle select?
      - vztahy retezcu s jidelnami - v jidelna_retezec_join podle id retezcu
      - jidelny - ve firma podle jidelna_firma_key vztahu
    - snidane
      - jidla - snidane na dany den v dane jidelne
      - objednavky - objednavky klienta na tato jidla
    - obedy - totez
    - vecere - totez - jidla na dany den by se mela vyhledat najednou, pak je rozdelit na snidane, obedy a vecere
    + dotaz na vsechna jidla jidelny na dany den (nejpomalejsi) - proc?

  = 4h

=== Mon, 21. 4. ===

- prace - alto
  - 2-3.30
    optimized ClientCanteenRelation.exists?
    - it no longer computes all client's relations just to see, if the given on
      among them
    - added Client#has_canteen_relation? and #has_chain_relation?
    - added Chain#has_canteen?
    - tested ClientCanteenRelation.exists?

    - refaktor a testovani ClientCanteenRelation, zjistovani dopadu, oprava
      nekterych

  = 1h30

=== Tue, 22.4. ===

- prace - alto
  - 6.45-7.15
    - reseni InvalidAuthenticityToken chyby pri snahu o odhlaseni po dlouhe dobe
      https://github.com/evzenk/objednavky/blob/master/doc/invalid_authenticity_token.txt
      - authenticity token se pouziva kvuli CSFR protection, ma omezenou
        platnost
      - protection lze upravit ve volani protect_from_forgery
        (ApplicationController) nebo preskocit before_action
        verify_authenticity_token (SessionsController)

  - 7.15-7.30, 8.15-8.45, 9-10.30, 11.30-12.30
    refactored ClientCanteenRelation
    - it no longer subclasses Struct
    - it stores the client
    - most methods moved from class to instance
    - added .any_exists?(client, canteen), which returns true if client has any
      relation to the canteen
    - .safe_new is no longer needed
    StoredRelation now checks presence of stored_canteen and stored_policy itself
      and no longer checks existence of the relation
    - existence is checked upon login and when placing order
    verification of authenticity token (CSFR protection) is now disabled for logout
    login by card now clears stored relation if invalid or nonexistent
    Client#has_canteen_relation? now ignores type if not specified
    Single and MultiplePortionsController now uses ClientCanteenRelation.any_exists?
      to check that current_client can still order in meal.canteen
    SessionsController was the only user of FailureHandling concern
    - fail_with_alert_t moved there, concern removed
    updated specs

  - 2-2.15
    added spec for Chain
    fixed bug in Chain#has_canteen - don't use find_by!

  - 3-3.15
    added some tests to Client and test notes for others

  - 3.45-4.45
    added test for Client#user_validation
    added test for client expiration date initialization

    Client.has_chain_relation? now ignores type if not given
    added specs for Client
    - find raises Client::NotFound
    - has_canteen_relation?, has_chain_relation?
    - simplified specs for add_canteen_relation, add_chain_relation using ^

  - 5-7.30
    simplified ClientCanteenRelation spec
    added spec for any_exists?

    tested all cases of ClientCanteenRelation#exists?
    - fixed bug - no longer returns true for nonexistent indirect relation if
      direct relation with canteen exists

    simplified ClientRelationsController spec using
      has_canteen_relation? and has_chain_relation?

    added specification, that stored_relation and thus current_relation may no
      longer exist (existence of relation is checked upon login and when placing
      order)

    made 'clear stored relation' and 'login by card' specs faster by mocking
      terminal_canteen instead of registering it

    login by card now works for indirect relations too, closes #33
    - added client_relations and consumers to Chain
    - added CanteenConsumer as abstraction on direct and indirect canteen consumers
    - implements .find(canteen, card_id)
    - used in SessionsController#create_by_card

    tested CanteenConsumer.find
    - find_indirect now returns nil when not found, not []

  - 8.15-9.30
    stored relations are now stored in a hash indexed by client.id

  = 9h

=== Thu, 24.4. ===

- prace - alto
  - 3h - reseni problemu s InvalidAuthenticityToken
    http://guides.rubyonrails.org/security.html
    http://devdocs.io/rails/actioncontroller/requestforgeryprotection/classmethods#method-i-protect_from_forgery
    http://stackoverflow.com/questions/7203304/warning-cant-verify-csrf-token-authenticity-rails

    skip_before_action :verify_authenticity_token, only: [:destroy]

    protect_from_forgery with: :exception, :only/:except => [<action>]
    - with options:
      :exception - Raises ActionController::InvalidAuthenticityToken exception.
      :reset_session - Resets the session.
      :null_session - Provides an empty session during request but doesn't reset it
        completely. Used as default if :with option is not specified.

  = 3h

=== Fri, 25.4. ===

- prace - alto
  - 4-5.30
    added basic order deadline support to single portion ordering
    - set @disabled flag in controller
    - disabled options and buttons in view
    - added feature spec
    fixed broken specs
    - meal factory now creates meal for tommorrow by default
    - added menu_for_date and menu_for_meal capybara helpers
    - used in order_meal, reorder_meal and unorder_meal helpers
    - used in placing single orders spec

  - 6-7.30
    disabled +/- buttons in mutliple portion menu after deadline
    - tested
    added Order#increase and #decrease
    - simplified MultiplePortionController
    changed order of OrderGetter.order(s)_for_meal(s)
      params to client, meal
    - updated calls

    showing warning in menu after order deadline
    - @deadline inst. var. replaced by helper method
    - tested

    updated info page

  - 9.45-11.15
    instalace a konfigurace postgresql
    konfigurace objednavek, aby se pripojili k postgres db
    konfigurace na serveru

  - 12-1
    added gems
    - letter_opener for email interception
    - exception_notification to send error notification emails from server
    - configured letter_opener as delivery method in development mode
    - added ExceptionNotification rack middleware in production mode

    update na serveru

  - 2-2.30
    added pg schema dump

    srovnani schematu se specifikaci, sepsani rozdilu

  = 6h

=== Sat, 26.4. ===

- prace - alto
  - 3-4
    updated db schema to be compliant with specification
    - added not null to client.client_id and .card_id
    - added default true to client.news
    - added not null to objednan.jidelna_key, .client_key, .pocet_objednano,
      .pocet_sezrano
    - added size limits to zamestnavatel.firma_id and .comment
    - dumped the schema
    - reannotated models

    updated employer views, helpers and specs after renaming name column to
      firma_id
    - the attribute is aliased to name, but in several places real column name
      is required

  - 5.15-6.45
    - domluva s evzou

    Client no longer validates presence of email
    added default 0 to objednan.pocet_objednano and .pocet_sezrano

    Order#init_portion_counts is no longer needed after adding defaults to
      schema
    added client, company and type presence validation to ClientCanteen and
      ClientChain
    added specs for these

    added validations
    - CanteenChain - canteen, chain (presence, uniqueness)
    - Company - type (length)
    - Employer - name, comment (length)
    - Meal - course, meal_number (length)
    added specs

  - 8-9.30
    removed unused code

    fixed client show page

    updated administration table filters
    - enabled searching for id
    - added auto reload for date filters (meal date, ordered_at)
    - added custom filter to meal course (wrapped attribute)
    - added translation for filter expansion

    InvalidAuthenticityToken is now handled by logging out and showing warning

  - 11-12
    nasazeni capistrano

  - 1.30-2
    added SimpleCov.at_exit hook to show uncovered files
    added SimpleCov groups

  = 5h30

=== Sun, 27.4. ===

- prace - alto
  - 6-7
    - studium bezpecnostnich aspektu railsu - https, session hijacing, csfr
    - rozmysleni ukladani vybrane jidelny v databazi
      - ukladat (jidenla, retezec, typ vztahu)
        - jednodussi (kdyz uz mame genericke overeni existence vztahu)
        - efektivnejsi ziskani techto entit (2 queries)
        - podstatne mene efektivni overeni existence vztahu
      - ukladat vztahy (klient-jidelna NEBO (klient-retezec A retezec-jidelna))
        - efektivni overeni existence (diky tomu lze delat pri kazdem requestu)
        - mene efektivni ziskani entit (az 4 queries)

    extracted remember_stored_relation spec from clear_stored_relation spec

  - 3h - navrh ukladani vybraneho vztahu v db
    specifikace:
    - pamatovat si vybrany pomer mezi prihlasenimi (remember_stored_relation_spec)
    - vycistit pri prihlaseni, pokud jidelna, retezec, nebo vztah prestali existovat
      (clear_stored_relation_spec)
    - prezit, pokud jidelna nebo retezec prestali existovat v prubehu
      (stored_relation_spec)
    - neumoznit objednavku, pokud prestali existovat (controller specs)

    moznosti:
    - ukladat jidelnu, retezec, typ vztahu - efektivni nalezeni komponent, podstatne
      pomalejsi overeni existence vztahu
    - ukladat id vztahu - (klient-jidelna NEBO (klient-retezec A retezec-jidelna)) -
      efektivni overeni existence vztahu, konstantne pomalejsi vyhledani komponent

    - existenci vztahu je treba overovat minimalne pri objednavce, objednavkovych
      requestu bude ale v menu vetsina (nebo velka cast), tudiz rychlost overeni
      existence je podstatna
    - efektivnejsi bude navic i nalezeni vsech vztahu (pro vyplneni vyberu), ktere
      se take dela pri kazdem requestu na menu

    -> zvolit druhou variantu

    - ClientCanteenRelation predelat tak, aby ukladal vztahy, zustanou aktualni
      readery (ale budou komplexnejsi) a konstruktory (a pribydou nove)
    - StoredRelation automaticky overuje existenci vztahu tim, ze vyhladava podle
      jeho id, stored_canteen, _chain a _type bud delegovat na relation, nebo
      ponechat jenom stored_relation a volat readery primo na nej
    - v SessionsControlleru nebude treba cistit session (taky usnadni volani
      reset_session kvuli hijackingu)
    - upravit CurrentCanteenController a _canteen_selection (hodnotami select
      optionu budou id vztahu, controller musi dekodovat)

    - vybrany vztah ulozeny v User se bude chovat jako asociace (ukladame id),
      belongs_to ale vraci nil, pokud nebyla asociace nalezena (vztah byl zrusen),
      vzhledem k tomu, ze klient muze mit bud primy, nebo neprimy vztah, treba
      rozlisovat mezi 'dany typ vztahu nebyl

  - 2h - studium moznosti benchmarkingu (treba porovnat rychlost pri delani vice
    queies vs. zpracovani v pameti)

    http://rubylearning.com/blog/2013/06/19/how-do-i-benchmark-ruby-code/
    https://github.com/evanphx/benchmark-ips
    http://www.ruby-doc.org/stdlib-2.1.1/libdoc/benchmark/rdoc/Benchmark.html

  - 1h - zjistovani moznosti upgrade na bootstrap 3
    - simple_form now supports bootstrap 3
    http://blog.plataformatec.com.br/tag/simple_form/
    - but 3.1.0.rc1 must be used
    - we're using 3.0.0.rc anyway

    - kaminari-bootstrap supports bs 3
    - wice_grid supports bs 3

  = 7h

=== Mon, 28.4. ===

- prace - alto
  - 6-10
    - rozmysleni poslednich detailu ukladani jidelny v databazi

    tested checking of relation existence in Orders::SinglePortionController
    simplified Orders::MultiplePortionController spec
    - needs to be simplified even more to test checking of relation existence
    - added notes for this
    added notes for checking existence of client-canteen relation in ordering
      controllers

    simplified Orders::MultiplePortionController spec

    extracted functionality shared by SinglePortionController and
      MultiplePortionController (Terminal, ordered_from, check_relation_exists)
      into OrdersController (their new parent)
    MultiplePortionController no longer handles OrderNotFound
    - this shouldn't happen and if it does, it's MenusController's fault
    SinglePortionController no longer handles NotYourOrderException
    - this should be prevented by CSFR protection
    added ClientController which checks that current_user is a client (not
      admin)
    - used as parent of ConsumptionsController, CurrentCanteenController,
      MenusController, OrdersController
    updated specs

    renamed singleton resources (menu, consumption, wellcome) from plural to
      singular

    tested that ordered_from is passed to
      order.increase and .decrease by Orders::MultiplePortionsController

  - 11.45-12.15
    - projiti kodu, sepsani dotcenych casti, poznamky ke zmenam

  - 12.30-3.30
    ClientCanteenRelation now stores ids of the
      relations - (client-canteen or (client-chain and chain-canteen))
    - updated ClientCanteenRelation, RelationPresenter
    selected relation is now stored in User, instead of cookies
    - added migration
    - updated User, StoredRelation, CurrentCanteenController
    - clearing of stored relation after login is no longer needed
      - updated SessionsController
    - renamed CanteenChain to ChainCanteen
      - updated Chain, Canteen
    updated specs

  = 7h30

=== Tue, 29.4. ===

- prace - alto
  - 4-4.30, 7-10
    StoredRelation#stored_relation now returns nil if
      any of the components (client, chain) seized to exist
    - added ClientCanteenRelation#reload and #components_exist?
    stored_relation is now memoized
    prepared hook for setting stored_relation to terminal_canteen after login
    updated specs

    refactored ClientCanteenRelation

    added ClientCanteenRelation::Base, ::Direct and
      ::Indirect to avoid testing direct? in every instance method
    - updated StoredRelation (the only one who needs to know about this change)
    simplified RelationPresenter spec

    extracted specs for ClientCanteenRelation::Direct
      and ::Indirect from ClientCanteenRelation spec
    tested ClientCanteenRelation.from_ids

    ordering controllers now check relation existence
      much more efficiently, relying on current_canteen and falling back to
      ClientCanteenRelation.any_exists? when meal.canteen != current_canteen
      (e.g. when ordering from duplicated tab after selecting another canteen)

  - 11-2
    tested login after related canteen/chain was deleted
    - added dependent: :delete_all to Canteen# meals, #client_relations,
      #chain_relations, Chain#client_relations and #canteen_relations
    - added default type to Relation.create

    tested clearing of both direct and indirect stored
      relation after login if relation or any of its components no longer exist

    - vybrat terminalovou jidelnu po prihlaseni

  = 6h30

=== Wed, 30.4. ===

- prace - alto
  - 6-8.30
    terminal canteen is selected after login on
      registered terminal
    - if selected relation was with terminal canteen, nothing happens
    - tested
    - added Chain#remove_canteen, find_canteen_relation
    - Chain#has_canteen? returns boolean (not the relation if exists)
    - added Client#find_canteen|chain_relation
    - Client#has_canteen|chain_relation? return boolean (not the relation)
    - added ClientCanteenRelation.find (redirects to Direct.find || Indirect.fi
    fixed grammar in login messages
    updated specs

    tested all cases of 'remember stored relation'
    renamed 'clear stored relation after login' spec to 'fall back if relation
      invalid'

    tested all cases of 'select terminal canteen after login'

    - rucni testovani funkcionality

    email is no longer a required field for client
    added host configuration to action_mailer in development
    cleaned up chain-canteen relations in db/seeds

    updated info page

  - 9-10
    optimized loading of client's relations
    - eager-loaded canteens in ClientCanteenRelation::Direct.for_client and
      ::Indirect.for_client
    - added inverse_of to all associations

    added spec for User

  - 10-10.30
    - experimentace s nactenim vsech objednavek klienta k jidlum na dany den
      najednou

  - 1-2
    - rozmysleni nacitani objednavek pro menu jednim dotazem

    simplified OrderGetter
    added notes for loading for menu orders in one query

  - 2-3
    - predelani OrderGetter tak, aby pouzival predloadovany seznam objednavek
      (predany v konstruktoru) a vyhledaval v nich (bez dalsich queries)
      - objednavky v menu nacteny jednou query

  = 6h
