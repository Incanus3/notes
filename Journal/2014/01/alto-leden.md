* prace - alto - soucet = 2+3+4+7+5+3+4+3+4 = 36h

==== Sunday, 19. January 2014 ====
* prace - alto = 2h
  - 3-4 - update na ruby 2.1, test rails 4.0.2 - nefunguje (gemy s tim jeste
    nepocitaji), pridan capybara test prihlasovani, pouzita mysql pro testy
    (sqlite se posira kvuli paralelnimu pristupu)
  - 10-11 - otestovano prihlasovani pri nepotvrzeni mailem

==== Tuesday, 21. January 2014 ====
* prace - alto = 3h
  - 10-10.30 - testovani prihlasovani kartou, pro formular bude treba form
    object, nebot nema smysl pouzivat resource (user), ktery nema ani
    jidelna_id, ani card_id
  - 1-1.45 - domlouvani s pepinem
  - 2.30-4.30 - pouziti form objectu v SessionsControlleru, testovani
    prihlasovani kartou

==== Wednesday, 22. January 2014 ====
- prace - alto = 4h
  - 10.15-11.15
  - 12.30-3.30

==== Thursday, 23. January 2014 ====
- prace - alto = 7h
  - 9-10 - support centralpointu
  - 10.30-11.30 - registrace terminalu
  - 12-12.45 - domlouvani objednavek s olinou
  - 12.45-3 - domlouvani s lenkou a pepinem
  - 6-8 - testovani registrace terminalu

==== Friday, 24. January 2014 ====
- prace - alto = 5h
  - 9-12 - dokonceni registrace terminalu
  - 2-4 - prihlaseni pomoci karty bez zadani jidelny

==== Wednesday, 27. January 2014 ====
- prace - alto - 3h
https://github.com/evzenk/objednavky/commit/3f7dad56ef59bf34c3d30b8b3df9141c33e55cbf
log in by card now shows correct alert when terminal not registered
added FailureHandling controller concern
added MockForm factory for form objects
Sessionscontroller and TerminalsController simplified using
  MockForm and FailureHandling, form objects removed
updated info page and login_by_card spec

==== Wednesday, 29. January 2014 ====
- prace - alto - 4h
https://github.com/evzenk/objednavky/commit/5ad9014640ba1c129b83a052bb48bd0bda406919
prepared for creating user along with client
added feature spec
clients/_form translated to haml, for create_user check box we'll need a form
  object as this field shouldn't be in client's model
capybara helpers and shared contexts moved to designated subdir of spec/support

https://github.com/evzenk/objednavky/commit/77ed7db7a41b89fc3c8d67a1013e206760d12348
implemented ClientForm as a wrapper around Client with additional create_user
  attribute, which is compliant with form_for and decent exposure
used it in ClientsController
updated controller spec
added explicit action to destroy button in _object_actions
  this isn't actually needed for ClientForm as it forwards model_name to Client,
  but we may not always wanna do that

==== Thursday, 30. January 2014 ====
* prace - alto - 3h
- renamed client expose to form
  added direct client for show and destroy
  spec updated
- extracted duplicated logic from administration controllers to AdminController
  redirect to index upon RecordNotFound now sets alert
  specs updated
- form object is now used only by new/create
  update form shouldn't have 'create user' checkbox and can work directly with
    client
  the form is no longer shared, only the client fields are
  ClientForm renamed to CreateClientForm

==== Friday, 31. January 2014 ====
* prace - alto - 4h
- user is now created along with client if the 'create user' checkbox is checked
  updated controller
  CreateClientForm now correctly converts create_user param from string to bool
  added CreateUser service object, that may create users for various occasions
    and provide correct defaults
  added String#to_bool to lib/monkeypatches and loaded it in config/application
    because this won't get autoloaded
  updated feature spec
- tested sending of confirmation mail after user creation
  refactored the feature spec
- tested that when the client is invalid, it doesn't create the user
  client needs to be reset for the client_fields partial when rendered by new,
    otherwise it uses the client provided by expose, which doesn't know the
    create_user params
  there aren't usually any params when calling new, but it this case they're
    passed from the create action
- association fields in client form now alow empty values
  these params are no longer required in controller, but the attributes are
    still required to save the model
  CreateClientForm now forwards errors to client
  moved flash rendering under admin tabs
  added notice when client destroyed
