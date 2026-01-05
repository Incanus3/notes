https://www.ruby-toolbox.com/
http://awesome-ruby.com/
https://github.com/markets/awesome-ruby
https://github.com/ruby-concurrency/concurrent-ruby
https://github.com/thoughtbot

https://github.com/tpope/gem-browse - use gem open to open gem with root set correctly, gem clone also works, gem browse shows homepage

http://www.ruby-doc.org/stdlib-2.0/libdoc/English/rdoc/English.html - rozumna jmena pro konstanty $!, $@, $;, ...

http://www.ruby-doc.org/stdlib-2.0/libdoc/pstore/rdoc/PStore.html , YAML::Store

https://github.com/egonSchiele/contracts.ruby

http://krainboltgreene.github.io/hexpress/ - constructing regular expressions in human readable form

https://codeclimate.com/ - automated ruby code review - code quality metrics

http://godrb.com/ - god is an easy to configure, easy to extend monitoring framework written in Ruby.
### performance
https://github.com/tmm1/perftools.rb - performance benchmarks for ruby apps - where the most execution time goes, method calls, bottlenecks
* fantastic discovery tool - e.g. when you just inherited a big software
https://github.com/tmm1/stackprof - sampling profiler, replacement for perftools.rb
http://samsaffron.com/archive/2013/03/19/flame-graphs-in-ruby-miniprofiler
https://github.com/tmm1/rbtrace - like strace for ruby
http://youtu.be/cOaVIeX6qGg
### data structures
https://github.com/intridea/hashie
- hashie is a simple collection of useful Hash extensions
### configuration
https://github.com/bkeepers/dotenv
- load environment variables from .env file (before aplication start)
### cli
http://whatisthor.com/ - build powerful command-line interfaces - used by bundler, rails
https://github.com/rails/thor

https://github.com/cowboyd/mvcli - framework for creating cli apps with rails-like architecture - templates, routes, ...

https://github.com/flori/term-ansicolor - probably better
### time
https://github.com/Intrepidd/working_hours
### http
https://github.com/tarcieri/http - very simple dsl for making http requests
https://github.com/lostisland/faraday
- Faraday is an HTTP client lib that provides a common interface over many
  adapters (such as Net::HTTP) and embraces the concept of Rack middleware when
  processing the request/response cycle.  It also includes a Rack adapter for
  hitting loaded Rack applications through Rack::Test, and a Test adapter for
  stubbing requests by hand.
### web
https://github.com/intridea/grape - An opinionated micro-framework for creating REST-like APIs in Ruby. http://intridea.github.io/grape
http://confreaks.com/videos/475-rubyconf2010-the-grapes-of-rapid
https://github.com/intridea/grape-entity
https://github.com/apotonick/roar
http://jaimeandres.github.io/grapevine/
https://github.com/sparklemotion/mechanize - ruby library that makes automated web interaction easy
### mailing
https://github.com/ryanb/letter_opener - Preview email in the browser instead of sending it. This means you do not need to set up email delivery in your development environment, and you no longer need to worry about accidentally sending a test email to someone else’s address.
### testing
https://github.com/bmabey/email-spec - rails mailer RSpec (, Cucumber, MiniTest) matchers
* UserMailer.send_wellcome(params).should reply_to(addr), deliver_to, deliver_from, bcc_to, cc_to
	* have_subject, include_email_with_subject, have_body_text, have_header

https://github.com/jnicklas/capybara#drivers - capybara-webkit - headless, can execute JS, faster; poltergeist - uses PhantomJS, 'truly headless', will detect javascript errors, may be even faster

https://github.com/bblimke/webmock - stubbing and expectations for HTTP requests - e.g. when communicating with external API

https://github.com/site-prism/site_prism - Page Object Model DSL for Capybara
### commerce
https://spreecommerce.org - open source eCommerce platform giving you full control and customizability
- https://github.com/spree/spree
### must-have list (pretty outdated)
- devise, simple_form (initializer), cancancan, capistrano(rvm, bundler, rails),
  sass-rails, bootstrap, hb, wice_grid, kaminari, kaminari-boostrap, mysql2,
  therubyracer, jquery-rails, jquery-ui-rails
- development - annotate, better_errors, binding_of_caller, pry-rails, pry-doc,
  rakc-mini-profiler, letter_opener
- test - shoulda-matchers, factory_girl_rails, minitest/rspec, capybara