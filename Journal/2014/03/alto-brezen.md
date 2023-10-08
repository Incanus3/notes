- soucet
  4 + 7 + 5 + 3 + 6 + 1 + 6 + 6.25 + 4.25 + 1.25 + 0.75 + 4 + 5.5 + 4 + 4.5 = 62.5

=== Mon, 3.3. ===

- 3.45-4.30
  - vytvorena tabulka zamestnavatelu (name, comment) - migrace, resource,
    controller, index akce + view - zobrazuje zakladni grid
  - upraven seed, asociace s klientem - migrace, uprava modelu
- 5-5.45
  - asociace s klientem - uprava Client::Create, modelu, find_if_id
    extrahovano do concernu a extendovano v Company i Employer
- 7.30-8
  - aktualizace ruby a gemu, interception haze error, protoze ruby21?
    porovnava == '2.1.0', ale v upstreamu uz je opraveno
- 8-8.30
  - pridana show akce - funguji linky z klienta
  - EmployersController dedi z AdminControlleru - testuje admin roli, ma admin
    layout - taby
  - do tabulky zamestnavatelu pridany id linky a akcni cudly
- 9-9.15
  - pridana new akce + view, do indexu pridan cudl Vytvorit
- 9.30-9.45
  - pridana edit akce + view
- 10.15-10.30
  - pridana create akce, zaměstnavatel validuje přítomnost názvu
- 10.30-10.45
  - pridana update akce
- 10.45-11.15
  - pridana destroy akce, otestovany redirecty
= 4h

=== Tue, 4.3. ===

- 7.30-7.45
  - simplified EmployersController using before_action
  - added notices
  - renamed employers table to zamestnavatel
  - simplified employer administration spec
- 9.15-9.30
  - removed employer company type
    changed default company type to canteen - migration
    reannotated models
    updated company spec
- 9.30-10
  - updated info page, gemfile
  - updated app on server
- 10-11
  - added many-to-many association between canteens and chains
    added jointable (migration) and CanteenChain model
    added associations to company
- 2-3
  - simplified usage of wrapped attributes
- 3.30-3.45
  - manual testing of administration after previous change
  - fixed error with old terminal registration cookie - Company::NotFound
- 3.45-4.15
  - removed instance methods and constructors from HashWrapper
    instance is never used
    added name_to_shortcut and shortcut_to_name class methods which perform
      conversion
    updated specs and models
- 4.15-4.30
  - renamed company_type to type, to be used with single table inheritance
- 4.30-5.30
  - simplified HashWrapper even more
    wrapped attribute is no longer needed
    reduced dynamic method definitions
    updated specs
- 5.45-6.15
  - added separated models for Chain and Canteen
    using single table inheritance
    STI doesn't work automatically, probably because type is wrapped,
      solved by setting default type and scope manually
    updated controllers using old company scopes
  - fixed bug in hash_wrapper
- 7.30-9
  - oddeleni administrace jidelen a retezcu
= 7h

=== Wed, 5.3. ===

- 9-9.30 - revize vcerejsich uprav - oddeleni administrace jidelen, commit
- 9.30-10.45
  - tested chain administration
    updated controller, navigation, views, spec
  - removed type from canteen and chain administration
  - updated info page
  - removed portion policy from chains
  - updated seeds
  - updated version on server
- 10.45-11
  - added chain list to edit canteen view
    tested in add chain to canteen spec
  - added chain to canteens in db/seeds
  - updated company factories not to conflict with names
- 11.30-12.45, 3.30-4.30
  - added form for adding chain to canteen in edit
    added form to view
    exposed chains that aren't already there
    added add_chain action + route
    added except_ids scope to Chain
    updated spec
  - problemy s form_for a selekci nepouzitych chainu
    Chain.where('id not in (?)', canteen.chain_ids) nefunguje, pokud je
      chain_ids []
- 16.45-17.30
  - canteen can be removed from chain in canteen edit
    added remove links to chain list
    added remove_chain action + route
    spec updated
  - form for adding canteen to chain is now inline
  - updated info page
  - added list of chains to canteen show
  - added list of canteens to chain show
  - updated seeds - added more chains
= 5h

=== Thu, 6.3. ===

- 12.30-1
  - added feature spec for client administration
    will be extended to test companies management
    disabled validation of client's company associations, since these will be
      changed to many-to-many relationships
    updated specs
- 1-1.30
  - priprava clients company management specu
- 10-12
  - studium single table inheritance - nefunguje, pokud neexistuje skutecne
    column type (nebo jiny - treba nastavit) typu string se jmenem modelu,
    virtualni atribut nestaci - vyresit s evzou, jak velky problem to je
    (firem neni moc), mohly by byt i oba sloupce, pokud se zkratkou uz evza
    nekde pocita
= 3h

=== Fri, 7.3. ===

- 11-1
  - created jointable for client companies
    added migration
    added ClientCompany model (bt client & company, wrap type, scopes)
    reannotated models
    ModelExtensions.wrap_attribute doesn't hide the accessors if the original
      new names are the same
  - disabled specs for client's companies management
  - created subclasses of ClientCompany for both company types
- 1.15-1.45
  - added company relations to Client model
  - added validations to ClientCompany
- 1.45-2.45
  - removed single relationships between client and companies
    removed Client belongs_to :chain and :canteen
    removed validations of company associations
    removed validations of client_id and card_id with respect to canteen and
    removed Company has_many :consumers
    removed :jidelna_firma_key and :retezec_firma_key columns from client
    updated Client spec and factories
  - updated ClientsController
    clients_grid includes relationships instead of single companies
    Client::Create and Update no longer sets canteen and chain
    removed set_companies from Client
    removed canteen and chain from client index, show and new/edit form
    updated spec
- 3-3.45
  - Employer raises Employer::NotFound
    Client::Create and Update rescue this
  - fixed specs
    models/company
    features/create_user_with_client
    services/client/create and update
  - added client_relations to Canteen
    Canteen has_many client_relations
    Canteen has_many consumers through client_relations
  - fixed login by card spec by creating relationship btw client and company
    correctly
  - set inheritance_column to none in Company and ClientCompany, otherwise we g
    error when setting type in mass assignment
  - renamed jidelak.jidelna_firma_key to firma_key
- 4-4.30
  - added canteens and chains to client through relations
    ClientAuth#current_canteen now returns first canteen of current_client
  - fixed MenusController spec, consumption spec - create relationships
  - updated shared contexts for login - create proper relationships
  - added factories for ClientCanteen and ClientChain
- 5.30-6.45
  - added administration of client-company relations
    admin can add/remove client to/from canteen/chain on client's edit page
    added routes - clients/add_canteen, add_chain, remove_relation
    added ClientRelationsController with appropriate actions
    added lists of current canteens and chains with delete buttons
    added forms for adding canteens and chains
    ClientsController#edit sets @canteens and @chains to companies not already
      in a relation with client
    added feature specs
  - moved except_ids scope from Chain to Company
  - fixed clients controller spec
  - added list of canteens and chains to client's show page
  - updated info page
= 6h

=== Sat, 15.3. ===

- 6.30-7.30
  - rebase test_meal_unordering on master, update rails
  - predelani single portion formulare na jednu routu - problem s routami
= 1

=== Mon, 17.3. ===

- 3-4 - dokoncen test pro single portion objednavani - formular predelan na
  jednu routu, akce se urcuje podle parametru
- 4-4.30
  - single order form moved from helper to view
  - cleaned up navbar helper
  - list of canteen's chains, client's chains and client's canteens
      now shows links instead of just names
  - removed unused table_headers helper and partial
- 5-5.30
  - removed portions_policy from Company
    added migration to remove the column
    removed attribute and validation from model, updated spec
    updated CanteensController, views, spec
    added ClientAuth#current_policy, MenusController now uses this,
      updated spec
    updated factories and feature specs
- 7.30-8.30,8.45-9.45
  - added canteen selection form
  - current_canteen now reads id from session and falls back to client's first
      canteen if none was selected
- 10-12
= 6h

=== Tue, 18.3. ===

- 11.30-12.30 - predelani feature testu vsech moznych alternativ vztahu
  klienta a jidelen na testy ClientAuth, feature test testuje jen zakladni
  funkcnost formulare
- 5-7.30,7.45-8.15 - hrani s SQL - snaha prijit na efektnivni (a activerecordem
  podporovany) zpusob, jak ziskat neprime vztahy klientu a jidelen
- 8.15-9
  - refactored Client#all_canteen_relations, removed duplicates
    ClientRelation renamed to CanteenRelation
  - provided potentially more efficient alternative default_scope to ClientCant
  - removed unused methods from BootstrapHelper and Meal
  + rucni testovani
- 9.30-10 - analyza efektivity nacitani neprimych jidelen klienta
- 0.30-1.30 - pridani eager loadingu, revize efektivity
= 6h15

=== Wed, 19.3. ===

- 1.30-3.30
  - current_client, current_canteen, canteen_relations, current_relation and
    canteens_for_selection are now memoized in ClientAuth
  - clear stored canteen id when canteen no longer exists
  - updated db/seeds and info page
  - deploy on server
- 9-9.30 - removed model names from create/update buttons in administration
- 10.45-11.45 - translated portions policy types in client administration
- 11.45-12 - translated meal course names in meal administration
- 12-12.15 - translated admin values (true/false) in user administration
- 12.15-12.30 - translated administration notices
= 4h15

=== Thu, 20.3. ===

- 3.30-4.30 - updated specs after translating notices
- 6-6.15 - hid registration links
= 1h15

=== Sat, 22.3. ===

- 6-6.45 - vymysleni inteligentniho ulozeni vybrane jidelny a retezce +
  nutnosti vymazani session mezi prihlasenimi
= 0h45

=== Sun, 23.3. ===

- 1-3
  - moved all logic concerning storing terminal registration
    in cookies to Terminal concern
    - TerminalsController no longer knows how the cookies are stored
  - renamed terminal registration cookies and methods to prevent colisions
  - monkeypatched Module to add define_class_method
  - used this in MockForm and HashWrapper
  - removed redundant subclassing of Struct from MockForm
  - extracted storing and loading of current relation
    to and from cookies to StoredRelation concern
    - chain and policy are stored too
  - ClientAuth uses this and adds defaults - simplified
  - CurrentCanteenController uses this
    - it is now only concerned about extracting values from params
  - Client::Relation holds chain too, updated canteen relations methods
  - canteen selector shows chain name for indirect relations
  - updated specs
- 4.30-5
  - moved Client::Relation from Client to separate file
    - added values_joined, split_values and to_s
    - simplified ClientsHelper and CurrentCanteenController
  - canteen selector now defaults to selected canteen
  - widened sidebar with canteen selector
- 5-6.30
  - updated canteen selection spec to include chain selection
  - added spec for Client::Relation
  - Client::Relation.split_values now converts ids to integer and type to symbo
  - added spec for CurrentCanteenController
  - simplified CurrentCanteenController spec, added security notes
= 4h

=== Mon, 24.3. ===

- 1.15-2
  - removed unused stylesheets
  - added spec for StoredRelation concern
  - stored_relation now checks that canteen belongs to chain and catches
    Company::NotFound
- 2.45-4.30
  - moved validity check of Client::Relation components from StoredRelation to
    Client::Relation.safe_new
  - moved related specs, simplified StoredRelation spec
  - simplified ClientAuth spec
    - other cases are now covered by specs for Client#all_canteen_relations and
      StoredRelation
  - added Client#add_canteen_relation and #add_chain_relation
  - used them all over the place
- 4.45-5.15
  - added happy path spec for ClientRelationsController
- 5.15-6
  - tested sad paths of ClientRelationsController
    - it now handles Client::NotFound, Company::NotFound and 'relation not found'
  - added shared examples for 'redirects back', 'shows notice' and 'shows alert'
  - used them all over the place
- 6.15-6.30
  - translated attribute names for validation errors
- 6.30-7
  - marked all required fields in administration
- 7-7.30
  - added unique constraints to client-company and canteen-chain join tables
  - db:migrate seems to ignore the name option if the autogenerated name is
    acceptable (e.g. not too long)
- 8.15-8.45
  - removed registration and omniauth links from login page
  - added back_path argument to BootstrapForms::FormBuilder#custom_actions and
    #create_update_actions to customize redirect path of the cancel button
  - used this in canteens and clients forms
    - cancel now works even after playing with relations
= 5h30

=== Tue, 25.3. ===

- 4.30-6
  - extracted CapybaraHelpers::CanteenSelection and shared context client_user
    from canteen selection spec (simplified)
  - prepared failing spec for saving canteen selection between sessions and
    clearing it if the relation no longer exists
  - stored relation is now cleared during log-in if the relation no longer
    exists
  - relation is now saved in cookies instead of in session, so it persists
    between sessions
  - added failing spec for correct redirection after login when session expired
- 6.15-7.45
  - simulace expirace devise session
- 8.30-9.30
  - client is now redirected to menu after log-in
  - admin is now redirected to administration after log-in
  - when user can't access page, he's redirected to root with alert
  - ClientAuth#current_canteen and #current_policy return nil when
    current_relation returns nil
  - MenusController redirects to root with alert if client has no canteen
    relation
  - finished testing of after-log-in redirections
= 4h

=== Wed, 26.3. ===

- 12.15-1
  - SinglePortionController now checks that client has relation with canteen
    before placing the order
  - added spec for this
  - updated controller spec
  - updated gems
- 3.30-4.15
  - SinglePortionController now sets order.ordered_from
    to terminal_canteen.name if terminal registered
    - updated controller spec
  - Terminal now memoizes terminal_canteen
- 4.45-5
  - duplicated placing_orders_spec to _single and _multiple
  - duplicated spec/support/capybara/helpers/meals to meals/single and
    meals/multiple
  - enclosed in CapybaraHelpers::Meals::Single and Multiple modules
  - updated including specs
- 7-7.30
  - created basic spec for placing multiple-portion orders
    - added course class to course menu table
    - added content_tag_for to meal row
    - updated CapybaraHelpers::Meals::Multiple
- 8-8.30
  - MultiplePortionController finds existing orders using id
    instead of by meal and client
  - when order not found, it redirects back with alert
  - updated controller spec
  - finished 'plcaing multiple-portion orders' feature spec
- 8.30-8.45
  - MultiplePortionController now sets order.ordered_from
    to terminal_canteen.name
  - tested in controller spec
- 8.45-9.15
  - Orders::MultilplePortionController now checks that
    client has relation to meal.canteen
  - extended 'ordering meal after relation with canteen was cancelled' spec to
    cover multiple-portion ordering
  - translated course in consumption history
= 4h30
