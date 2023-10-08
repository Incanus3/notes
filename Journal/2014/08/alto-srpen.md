=== Wed, 6.8. ===

- prace - fs
  - 5h30
    - refactoring God wrapperu

    - server-management:
      added bundle exec to guard rspec command
      fixed specs after changing error during object creation to critical

    - tasks:
      added meaningful messages to error classes

    - integration-testing:
      moved mysql specs to subfolder

      - rozmysleni spousteni vice instanci sm vedle sebe z testu
      - zkoumani existujicich skutecnych (nemockujicich) testu webhostingu,
        ktere by se daly prenest na uroven posilani zprav

    - pocatek vytvareni integracnich testu pro webhosting

    - vytvoreni factory pro webhosting message
      - pouziti dependent a transient attributu podle dokumentace
      - problem - transient zatim nefunguje (az od factory_girl 5)
        - treba pouzit ignore

    started creating integration tests for webhosting management
    - added simple spec - testing creation of system user
    - enabled web god watch
    - added webs_path and apache_conf_path to configuration
    - overrided log_file in 'start management' config to match watcher_name
    - added factory for webhosting message

    - snaha o spusteni sm pod rootem
    - nastaveni sudoers tak, aby fungovalo rvmsudo
    - uprava God::CLI, aby volalo pres rvmsudo
    - volani godu rucne pres rvmsudo funguje, volani z testu ale rve
sudo: sorry, you are not allowed to set the following environment variables: BUNDLE_GEMFILE, RUBYOPT, _ORIGINAL_GEM_PATH, RUBYLIB
http://www.sudo.ws/sudoers.man.html

  - 5-5.30 - zprovozneni predani envvars pres rvmsudo

  = 6h
=== Thu, 21.8. ===

nastaveni sudo kvuli integration-testingu rozbije path pro roota

- prace - alto
  - 11-12 - pridani faviconu

== Rails ==
http://weblog.rubyonrails.org/2014/8/20/Rails-4-2-beta1/
https://github.com/plataformatec/responders
- additions to respond_with - setting of flash, redirect location, cache,
  collection

== Console framework (ncurses alternative ==
https://github.com/gavinlaking/vedeu
https://github.com/gavinlaking/playa - example app
=== Sat, 23.8. ===

[] vyřešit faktury za telefon
[] poslat router na UPC

- prace - fs
  - 0h30 - dodelani integrace gitlabu a redmine
  - 4.30-5 - upgrade gitlabu na 7.2
  = 1h

- nenajde useradd (a spousti pres sh, nikoli bash) - zjistit pod jakym userem
  bezi a jaka je path
=== Tue, 26.8. ===

- aplikace k projiti kvuli gemum:
- ssk-zam, rujan, limam, krieg

- prace - fs
  - 10-11
    - snaha o rozbehnuti inventarizace
    $ bundle exec ruby test/unit/ability_test.rb
      /home/jakub/.rvm/gems/ruby-1.9.3-p547@inventarizace/gems/rails-2.3.16/lib/rails/gem_dependency.rb:21:in `add_frozen_gem_path': undefined method `source_index' for Gem:Module (NoMethodError)
      http://stackoverflow.com/questions/15349869/undefined-method-source-index-for-gemmodule-nomethoderror
    - treba downgrade rubygems na < 2.0.0
    $ gem update --system 1.8.25

    $ bundle exec ruby test/unit/ability_test.rb
      config.gem: Unpacked gem authlogic-2.1.6 in vendor/gems has no specification file. Run 'rake gems:refresh_specs' to fix this.

    $ bundle exec rake gems:refresh_specs
      undefined method `installed_source_index' for #<Gem::SourceIndex:0x000000020f2cb8>
      http://stackoverflow.com/questions/2278847/how-do-i-fix-this-error-config-gem-unpacked-gem-authlogic-2-1-3-in-vendor-gems

    - treba vygenerovat rucne
    $ cd vendor/gems/authlogic-2.1.3
    $ gem specification authlogic > .specification

    $ cp database.yml.example database.yml

    cannot load such file -- test/unit/ui/console/testrunner (MissingSourceFile)
    - pridan test-unit do Gemfile

    - syntax error v vendor/plugins/resource_fu/lib/resource_fu.rb
      - 67 radek - when pouzito jako if bez else - deprecated
      - downgrade ruby nebo upgrade resource_fu (ale proc je ve vendor? nedelal
        vojta nejake zmeny?)

  = 1h
=== Wed, 27.8. ===

- prace - fs
  - 6.45-7.15
    - downgrade na ruby 1.8.7
    - downgrade rubygems
    - pridani sqlite3 gemu
    - rake db:setup pro vsechny prostredi
    - zakomentovan redgreen gem
    $ bundle exec rake test
      223 tests, 881 assertions, 0 failures, 5 errors

    The {{key}} interpolation syntax in I18n messages is deprecated. Please use %{key} instead.
    - nahrazeno v config/locales/cz.rb
    :%s/{{\(.\{-}\)}}/%{\1}/g
    .\{-} = non-greedy .*

  - 8-9
    - pokusy
      - prozkoumani rout - vsechny maji prefix account_id
      - seedy generuji account (s domenou 'domena') a 3 ucty
      - snaha o zobrazeni jakekoli stranky skonci na authlogic
        - Filter chain halted as [:account_required] rendered_or_redirected.
      - account_id neni porovnavano s id, nybrz s domenou accountu - treba
        navstivit localhost:3000/domena
      - prihlaseni jako admin, vytvoreni majetku (vcetne druhu, umisteni,
        sbirky a kategorie), jeho vypujceni, prihlaseni jako user, kontrola
        vypujcky
      - preformatovani collection testu

  = 1h30

- zjistit, jak funguje prihlasovani - kde se porovnava account_id s domenou
  accountu
-> nastudovat authlogic

- projit ApplicationController a potom postupne jednotlive controllery a modely,
  ktere vyuzivaji

http://graysoftinc.com/rubies-in-the-rough
=== Fri, 29.8. ===

- prace - fs
  - 8.30-9 - prochazeni collection testu
  - 12.30-3.30

  = 3h30

- prace - alto
  - 1h - oprava ubuserveru - apple
=== Sat, 30.8. ===

- prace - fs
  - 1-1.30 - odstraneni starych kernelu na node1 a 2, web1a a b, nebula
  - 3-3.30 - inventarizace
    - pokracovani hrani s collections
      - collection a property pokryvaji nejvetsi cast kodu - rozlustit a
        rozsekat je jako prvni
      - vytvorit diagram modelu a jejich zavislosti
      - Account has_many Users and User belongs_to Account,
        but Collection belongs_to Account and User
      - is this collection.account always == collection.user.account
  - 6-7.15 - studovani modelu, vytvoreni grafu associaci
  - 7.15-7.30 - pridani pameti productionu
  - 7.30-8 - zmena operatoru na && a ||, dalsi drobne zmeny
  - 2-3 - snaha o refactor importu properties z CSV
  = 3h

- prace - alto
  - 1.30-3
    - odstraneni initskriptu apple
    - instalace fail2ban
    - upgrade na ubuntu 14.04
    - vyhledani a reinstalace hacklych balicku (ps, netstat, ss, lsof)
    - upgrade na postgresql 9.3
  = 1h30
=== Sun, 31.8. ===

- prace - fs
  - 5-7.15

  = 2h15

bundle exec ruby -I"lib:test" test/unit/property_test.rb --verbose=verbose -n
/import/
