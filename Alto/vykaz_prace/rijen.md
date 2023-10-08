Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-11-02T11:58:17+01:00

====== rijen ======
Created Saturday 02 November 2013

===== soucet =====
14. - 5h30
15. - 1h30
16. - 5h30
17. - 4h15
18. - 5h30
19. - 7h
20. - 2h
21. - 6h

23. - 7h
24. - 4h30
25. - 4h30
26. - 4h45
27. - 5h30
28. - 3h
29. - 3h30

31. - 5h
= 75h

===== Monday 14 Oct 2013 =====
* 30 min - nasazeni objednavek
	* vytvoreni rvm wrapperu pro pumu (puma nemuze bezet pod userem alto, protoze ten nema prava poslouchat na portu < 1000
	* rvm je nainstalovane pro usera alto, takze root k nemu nema pristup
* 5-7.30 - refaktoring (hlavne OrdersController), cisteni
* 11-2 - pridani devise, zakladni nastaveni, vytvoreni testovaci mailove schranky pro odesilani mailuj
= 5h30

===== Tuesday 15 Oct 2013 =====
* 2.30-4 - analyza moznosti registrace
= 1h30

===== Wednesday 16 Oct 2013 =====
* 12.15-1.45 - vytvareni iniscriptu pro centralpoint
* 5-7
	* by default all actions now require authentication
	* added info page, that doesn't, set as root
	* fixed log out link
	* translated most common devise notices to czech
	* added debug link to delete all users to info page
	* set smtp settings for objednavka@altopraha.cz email account
	* translated some more devise messages
* 11.45-1.45
	* more devise messages translated
	* added options to edit and cancel registration
	* updated assets settings for production environment
	* added puma to gemfile
	* vytvořen initskript - problémy s assety, parametry pumy, pravy, ...
	* adding_devise mergenuto do masteru
= 5h30

===== Thursday 17 Oct 2013 =====
* 1-2.45
	* moved info page (and drop_all_users action) to new WellcomeController, routes updated
	* if there is a client with email address matching current user's mail, the orders are created for this client
	* added creation of initial admin to seeds and drop_all_users action updated info page
* 5.30-6
	* administration links moved from main navbar to tabs
* 10.30-12
	* extracted showing of daily menu from Orders to MenuController
	* moved concerned views and helpers
	* fixed higlighting of active navigation tab and added highlighting of current administration tab
	* updated routes
	* removed delete account link, this is accessible from edit profile page
* 3.30-4
	* formulace mailu holkam
= 4h15

===== Friday 18 Oct 2013 =====
* 5.15-7.15
	* set_canteen moved to ApplicationController, will be removed once current_canteen is identified by current_client
	* removed SessionsController, views, helper and assets
	* refactored administration index views
		* created helpers for page_header, pagination, table_headers (with partial), index_actions (with partial) and new_button
		* used them in all index views
	* updated db seeds
	* activated account locking after 5 failed login attempts, messages translated
* 9.50-10.20 - datastore wrapper, initskript
* 12.20-12.50
	* added views for devise emails (confirmation, reset password and unlock instructions) and translated them
	* fixed devise mail sender
	* added confirm to drop_all_users
* 1-2
	* added and translated devise views
	* fixed date selection (moved date_params from Orders to Menu)
	* allowed 5 minute access to non-confirmed user
* 2.10-3.40
	* user forms converted to bootstrap horizontal forms
	* monkeypatched BootstrapForms::FormBuilder
	* added horizontal_form_for helper
	* used these in views (confirmations, passwords, registrations, sessions, unlocks)
= 5h30

===== Saturday 19 Oct 2013 =====
* 1-4.30 - srani s formulari tak, aby dalsi buttony byly uvnitr formu
* 5.30-6 - zobrazit denni menu po prihlaseni, pokud jsem pred prihlasenim neklikl na jiny odkaz
* 12-3 - studovani zdrojaku devise, pouziti request.env a permanentnich cookies pro registraci terminalu
= 7h

===== Sunday 20 Oct 2013 =====
* prace - alto - 2h - pridavani testovaciho frameworku, konfigurace generatoru, spring, guard
= 2h

===== Monday 21 Oct 2013 =====
* prace - alto - 10-4 - pretizeni DeviseControlleru - prihlaseni bez hesla
= 6h

===== Wednesday 23 Oct 2013 =====
* 12-2
	* debug spatneho formatu pri prihlaseni kartou, kdyz uzivatel jeste nepotvrdil mailovou adresu - format je detekovan jako user, diky tomu se zobrazi pouze notice jako text
	* pry-debugger - next/finish nefunguje spravne s ruby 2.0
	* irc - pry-buybug by mel fungovat s 2.0, ale segfaultuje
	* instalace 1.9.3 - vytvoreni gemsetu, bundle (instalace rails trva)
	* irc - odinstalovat pry-exception_explorer - pak uz nesegfaultuje
	* #<NoMethodError: undefined method `interface' for #<PryByebug::Processor:0x00000007e1a2d8>>
* 6-7
	* customizace alto serveru - bashrc, emacs
* 7.30-8.30
	* pridany footnotes
	* obejiti devisu v testech, problemy s cleanupem databaze po kazdem testu
* 9-11
	* reseni wrapperu s evzou
	* testovani FirmasControlleru
* 3-4
	* refactor + testovani FirmasControlleru
= 7h

===== Thursday 24 Oct 2013 =====
* 1h30 - testovani clients controlleru
	* ClientController now properly handles RecordNotFound exception
	* refactored using respond_with
	* added tests
* 7-8.30 - refactoring clients controlleru
	* refactored ClientsController
		* create and update now accept association keys directly
		* simplified spec
	* clients _form partial view refactored using horizontal_form helper
	* extracted sign in hooks from specs to helper
* 9-9.30
	* tested that login is required for FirmasController and ClientsController actions
* 1.30-2
	* added specs for ClientsController's new and edit actions
	* tested assignment of companies of different types
* 2-2.30
	* created basic presenter superclass
	* replaced company variables from ClientsController by ClientPresenter methods
	* used presenter in clients view form
	* removed tests for these variables from ClientsController spec
= 4h30

===== Friday 25 Oct 2013 =====
* 7-8
	* moved company group helpers from ClientPresenter to FirmasHelper,
	* used it directly in clients form partial
	* added tests for this
	* installed rb-readline to fix readline issue in guard
	* guard-spring no longer needed, spring is started by guard :rspec cmd option
* 8.30-10 - testovani JidelaksController
* 11-1 - debuggovani ulozeni data z date_selectoru do virtualniho (aliasovaneho) parametru
	* https://rails.lighthouseapp.com/projects/8994/tickets/2675-support-for-multiparameter-attribute-assignment-on-virtual-attribute-writers
= 4h30

===== Saturday 26 Oct 2013 =====
* prace - alto - 3.30-4.30 - association parameters for client (jidelna, retezec, zamestnavatel), moved to nested fields_for, which is much safer than setting <assoc>_firma_key directly (enforces existence of company with such id), monkeypatched bootstrap_forms fields_for helper
	* 4.45-5.30 - updating specs
	* 12-2 - extracting PortionsPolicy from Firma
	* 2-3 - abstracting HashWrapper from PortionsPolicy, to be usable for e.g. CompanyType
= 4h45

===== Sunday 27 Oct 2013 =====
* 3.30-4 - pridani testu k HashWrapperu
* 4-4.30 - extrakce CompanyType z Firmy
* 5-6 - validace povolenych hodnot v naslednicich HashWrapperu (CompanyType, PortionsPolicy) a nasledne ve Firme
* 7-7.30 - pridani testu clientu
* 8-8.30 - extrakce Course z Jidelaku
* 8.30-9 - uprava jidelak view formu na bootstrap, pokuziti fileds_for pro jidelnu, Course.names pro typ chodu
* 9-9.30 - doplnovani testu jidelaku, problemy s dvojitou validaci wrappovanych atributu
* 12.30-1.30 - zjednoduseni a zlepseni validace wrappovanych atributu
* 1.30-2 - konecna refaktorizace modelu Firma a Jidelak - extrakce wrapovani atributu do BaseModel, doplneni testu
= 5h30

===== Monday 28 Oct 2013 =====
* 4-4.30 - pridani testu k order
* 5-5.30 - extrakce OrderGetter z Order
* 6-8 - reseni efektivniho mapovani ActiveRecord::Relation (relation sice pretezuje select, ale ten se stejne nechova lazy, treba pouzit lazy rucne, zjistovani, zda to staci)
	* aktualizace seedu, problemy s migraci kvuli alias_multiparam_attribute, Firma#type (koliduje s AR mass assignment)
	* extrakce metod tykajicich se zobrazovani z Order do OrderPresenter, problem s model_class (pouzito v link_to)
* 7-8 - refaktor OrdersController pomoci helper metod (dalo by se jeste zredukovat pouzitim decent exposure)
= 3h

===== Tuesday 29 Oct 2013 =====
* 30 min - rozsekani ApplicationHelpers
* 1-4 - refaktor application layoutu, vycisteni stylu (administrace, stylesheety), sidebar, presun admin panelu, vyberu jidelny
= 3h30

===== Thursday 31 Oct 2013 =====
* 30 min - reseni detailu vzhledu, skryti alertu po timeoutu
* 20 min - testovani mailu (chyba hlasena lenkou se neprojevila), vycisteni index views
* 4.30-5.15 - zanoreni puvodniho OrdersControlleru do modulu Orders jako CrudController, uprava routes a views, testovani
* 5.20-6 - extrakce SinglePortion a MultiplePortionControlleru z CrudControlleru, uprava routes a views, testovani, vycisteni
* 6-7.15 - zjednoduseni FirmasControlleru pomoc decent_exposure -> zbaveni se ivars ve views, uprava specu
* 7.50-8.35 - totez pro ClientsController a JidelaksController
* 9.10-9.35 - svazani jidelny s aktualnim klientem, skryti vyberu jidelny, aktualizace seedu, info page
* 9.40-10 - vycisteni Orders::CrudControlleru pouzitim respond_with a decent_exposure
= 5h
