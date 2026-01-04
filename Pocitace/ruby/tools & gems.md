https://www.ruby-toolbox.com/

https://github.com/tpope/gem-browse - use gem open to open gem with root set correctly, gem clone also works, gem browse shows homepage

https://github.com/tarcieri/http - very simple dsl for making http requests

http://krainboltgreene.github.io/hexpress/ - constructing regular expressions in human readable form

http://www.ruby-doc.org/stdlib-2.0/libdoc/English/rdoc/English.html - rozumna jmena pro konstanty $!, $@, $;, ...

http://www.ruby-doc.org/stdlib-2.0/libdoc/pstore/rdoc/PStore.html , YAML::Store

https://github.com/tmm1/perftools.rb - performance banchmarks for ruby apps - where the most execution time goes, method calls, bottlenecks
* fantastic discovery tool - e.g. when you just inherited a big software

https://codeclimate.com/ - automated ruby code review - code quality metrics

http://godrb.com/ - god is an easy to configure, easy to extend monitoring framework written in Ruby.
### cli
http://whatisthor.com/ - build powerful command-line interfaces - used by bundler, rails
https://github.com/rails/thor

https://github.com/cowboyd/mvcli - framework for creating cli apps with rails-like architecture - templates, routes, ...

https://github.com/flori/term-ansicolor - probably better
### web
https://github.com/intridea/grape - An opinionated micro-framework for creating REST-like APIs in Ruby. http://intridea.github.io/grape
http://confreaks.com/videos/475-rubyconf2010-the-grapes-of-rapid
https://github.com/intridea/grape-entity
https://github.com/apotonick/roar
http://jaimeandres.github.io/grapevine/
### mailing
https://github.com/ryanb/letter_opener - Preview email in the browser instead of sending it. This means you do not need to set up email delivery in your development environment, and you no longer need to worry about accidentally sending a test email to someone else’s address.
### testing
https://github.com/bmabey/email-spec - rails mailer RSpec (, Cucumber, MiniTest) matchers
* UserMailer.send_wellcome(params).should reply_to(addr), deliver_to, deliver_from, bcc_to, cc_to
	* have_subject, include_email_with_subject, have_body_text, have_header

http://pivotal.github.io/jasmine/ - RSpec-like testing framework for javascript

https://github.com/jnicklas/capybara#drivers - capybara-webkit - headless, can execute JS, faster; poltergeist - uses PhantomJS, 'truly headless', will detect javascript errors, may be even faster

https://github.com/bblimke/webmock - stubbing and expectations for HTTP requests - e.g. when communicating with external API
