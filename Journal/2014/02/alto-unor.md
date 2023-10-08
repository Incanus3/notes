* prace - alto - soucet = 1+1+3+4h45+2+3h30+4h45+1+5+3+1 = 30h

==== Saturday, 01. February 2014 ====
* prace - alto = 1h
  - simplified create user with client spec using custom matchers and shared
      contexts = 30 min
    when user is created along with client, it's bound to him now
    translated model names
  - when creating user with client, password defaults to email = 10 min
    updated info page
  - tested rendering of validation errors when client invalid = 10 min
  - poslan mail lence = 10 min

==== Sunday, 09. February 2014 ====
- prace - alto - 1h - smazani usera spolecne s klientem

==== Monday, 10. February 2014 ====
- prace - alto - 3h - extrakce CreateClient z ClientControlleru

==== Tuesday, 11. February 2014 ====
- prace - alto - 8-9, 10-12, 1.15-3 = 4h45 - extrakce zbytku logiky z
  ClientControlleru

==== Thursday, 13. February 2014 ====
- prace - alto = 2h
  - 11-12 - aktualizace gemu, spraveni guard + spring, dokonceni refaktoringu
    ClientsControlleru pomoci servicu
  - 12.30-1 - refaktoring obslouzeni RecordNotFound
  - 1-1.30 - osetreni AR::RecordNotFound ve vsech controllerech

==== Friday, 14. February 2014 ====
- prace - alto = 3h30
  - 2.45-3 - extrakce casti spec_helperu pro zrychleni testu
  - 5-5.15 - ClientsController#update test zmenen na rychly mocking test
  - 5.15-6 - zbytek ClientsController testu zmenen na rychly mocking test
  - 6.30-7.15 - vytvoren test pro Client::Create service
  - 9.30-10 - otestovano volani Client::Create z ClientsController#create
  - 10-10.30 - otestovano volani Client::Update z ClientsController#update
  - 10.30-11 - zjednoduseni ClientsController testu

==== Saturday, 15. February 2014 ====
- prace - alto = 4h45
  - 3.30-4.30 - reseni validace usera pri ulozeni klienta, ukladani zaroven -
                zajisteni, aby se neulozil jeden bez druheho
  - 5-5.30 - testovani User::Create service
  - 6.15-6.45 - ..., oprava User::Delete po pridani dependent: :nullify do
    Client has_one :user
  - 6.45-7 - dokonceni User::Create testu - pokryty vsechny moznosti - neulozi
    ani klienta ani uzivatele, pokud je nektery z nich invalid
  - 7-7.30 - drobne upravy ClientsControlleru
  - 7.30-7.45 - Client::Create can raise Firma::Not found - tested
  - 8.45-9 - Client::Create returns invalid client even when company couldn't be
    found
  - 10.30-11 - planning of moving portions policy to client - notes in
    MenuController
  - 2-3
    - added notes for binding policy to client instead of canteen
    showing only 7 days in menu, better formatting
    - added placeholder for canteen selection form to sidebar in client layout
      (used in menu)
    - created background for feature spec for daily menu will test high level
      functionality of different menu options (policies, selected canteen, ...)
    - moved feature spec to subfolders for admin, client and login

==== Sunday, 16. February 2014 ====
- prace - alto = 1h
  - 3.30-4
    - softened validations of client's companies
      - client must have employer only if he has canteen
      - client must have either canteen or chain
    - updated spec
    - extended menu feature spec
  - 4.30-5
    - menu feature spec - added case for chain-only user
      - added context and factory
    - canteen_selector partial shows selection only if @show_canteen_selection set

==== Tuesday, 18. February 2014 ====
- prace - alto = 5h
  - 6-7 - started modifying menu_controller_spec to test selected canteen,
      which will be stored in session and selected in form (if allowed for client)
    canteen_id, chain_id and employer_id params aren't required in ClientsControll
      any more
    ClientsController calls valid? on client instead of persisted?, otherwise
      validation errors aren't shown
    updated spec
    updated info page
    updated gems
    - updated on server
  - 8-10 - translated Meal model and controller
  - 11-12 - translated Company model
  - 12-1 - translated Client model and the rest

==== Wednesday, 19. February 2014 ====
- prace - alto = 3h
  - 4.30-5.15
    - made menu resourceful
      updated route, controller, views, spec, navigation
    - made consumption resourceful
      updated routes, controller, view, navigation
      added basic consumption feature spec
    - extended consumption spec
      added html attributes to consumption table and menu
  - 6.45-7
    - moved capybara helpers to modules which can be included separately
  - 7-8
    - testovani menu - problemy s objednavacim formularem, do ktereho je
      nacpane tlacitko na zruseni
    - WIP: uncovered problem with testing meal unordering using capybara
      the unorder button is stuffed into the meal ordering form (which already
        has one submit button) and hacked to work using formaction
      this is probably bad, but we need the button to appear inside of the form
      the other possibility is not to set formaction and have a test for commit param
        (button text) in the action, thus to have same action being called for two
        different operations, which is bad too
      another option is to use javascript for this, which may be needed later anyway
      the hack is in app/helpers/menu_helper.rb
  - 8-9
    - added meals association to canteen
      meals factory sets date to Date.today, not in sequence
      reorganized capybara shared contexts
    - fixed date selection in menu
      removed database reinitialization from wellcome controller
      created basic wellcome page spec
      disabled simplecov filter for line counts

==== Thursday, 20. February 2014 ====
- prace - alto = 1h
  - 4.30-4.45 - made wellcome and terminals resourceful
  - 5-5.45 - tested Client::Update service
    User::Create and User::Update returns client even when associations can't be
    found, which is nice because we can render form with the invalid user, but
    if an optional association isn't found, we don't learn about it, which is
    dangerous
    - the services should probably set validation errors on associations that
      weren't found
