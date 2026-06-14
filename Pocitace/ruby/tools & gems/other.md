### General Ruby resources
- https://www.ruby-toolbox.com/ - directory for discovering and comparing Ruby gems by category, popularity, and maintenance activity
- https://awesome-ruby.com/ - curated “awesome Ruby” list of libraries, tools, frameworks, and software
- https://github.com/markets/awesome-ruby (last update 06/2026) - GitHub source for Awesome Ruby, a curated collection of Ruby libraries/tools/frameworks
- https://github.com/thoughtbot - Thoughtbot’s GitHub organization with many widely used Ruby/Rails gems and examples
- https://github.com/tpope/gem-browse (last update 02/2023) - use `gem open` to open gem with root set correctly; `gem clone` also works, `gem browse` shows homepage
- http://www.ruby-doc.org/stdlib-2.0/libdoc/English/rdoc/English.html - reasonable names for Ruby special globals/constants like `$!`, `$@`, `$;`, ...

### Concurrency
- https://github.com/ruby-concurrency/concurrent-ruby (last update 06/2026) - modern Ruby concurrency primitives such as futures, promises, thread pools, agents, and supervisors

### Language patterns / utilities
- http://www.rubypigeon.com/posts/a-review-of-immutability-in-ruby/ - article reviewing immutability approaches and shared mutable state in Ruby
- http://www.ruby-doc.org/stdlib-2.0/libdoc/pstore/rdoc/PStore.html - Ruby stdlib transactional file-backed object store; related to `YAML::Store`
- https://github.com/egonSchiele/contracts.ruby (last update 01/2026) - design-by-contract style runtime type/contracts library for Ruby
- http://krainboltgreene.github.io/hexpress/ - constructing regular expressions in human-readable form
- https://github.com/intridea/hashie (last update 02/2026) - simple collection of useful Hash extensions
- https://github.com/Intrepidd/working_hours (last update 01/2026) - Ruby library for calculating and working with business hours / working time

### Quality, metrics, and monitoring
- https://codeclimate.com/ - automated code review and code quality metrics
- http://godrb.com/ - easy-to-configure and extensible process monitoring framework written in Ruby
- https://github.com/ctran/annotate_models (last update 08/2024) - adds schema comments to Rails models and fixtures

### Debugging
- https://github.com/BetterErrors/better_errors (last update 07/2024) - better Rails/Rack error page with source context and interactive inspection
- https://github.com/banister/binding_of_caller (last update 02/2026) - exposes caller bindings for debugging, commonly used by better_errors
- https://github.com/rweng/pry-rails (last update 06/2024) - Rails console integration for Pry, replacing IRB with Pry in Rails console
- https://github.com/pry/pry-doc (last update 01/2026) - Pry plugin that adds MRI C source and Ruby core documentation lookup

### Performance and profiling
- https://github.com/tmm1/perftools.rb (last update 07/2020) - performance benchmarks for Ruby apps; shows where execution time goes, method calls, bottlenecks
  - fantastic discovery tool, e.g. when you just inherited a big software project
- https://github.com/tmm1/stackprof (last update 03/2026) - sampling profiler for Ruby; replacement for perftools.rb
- http://samsaffron.com/archive/2013/03/19/flame-graphs-in-ruby-miniprofiler - article on using flame graphs in Ruby MiniProfiler
- https://github.com/tmm1/rbtrace (last update 12/2025) - tracing/debugging tool for live Ruby processes, roughly “strace for Ruby”
- http://youtu.be/cOaVIeX6qGg - video resource related to Ruby performance/profiling
- https://github.com/MiniProfiler/rack-mini-profiler (last update 04/2026) - Rack middleware for profiling requests, SQL, memory, and page rendering in Ruby web apps

### Configuration
- https://github.com/bkeepers/dotenv (last update 12/2025) - load environment variables from `.env` before application start

### CLI
- http://whatisthor.com/ - framework for building command-line interfaces, used by Bundler and Rails
- https://github.com/rails/thor (last update 05/2026) - Thor CLI toolkit source repository
- https://github.com/flori/term-ansicolor (last update 03/2026) - ANSI color/control-sequence library for Ruby terminal output; probably better

### HTTP
- https://github.com/tarcieri/http (last update 05/2026) - very simple DSL for making HTTP requests
- https://github.com/lostisland/faraday (last update 06/2026) - HTTP client library providing a common interface over adapters like Net::HTTP, plus Rack-style middleware, Rack::Test, and request stubbing support

### Web / API
- https://github.com/intridea/grape (last update 06/2026) - opinionated micro-framework for creating REST-like APIs in Ruby; see also http://intridea.github.io/grape
- http://confreaks.com/videos/475-rubyconf2010-the-grapes-of-rapid - RubyConf talk about Grape / rapid API development
- https://github.com/intridea/grape-entity (last update 06/2026) - entity/presenter layer for exposing objects in Grape APIs
- https://github.com/apotonick/roar (last update 01/2023) - Ruby object representation / hypermedia API serialization toolkit
- http://jaimeandres.github.io/grapevine/ - Grape-related API tooling/resource
- https://github.com/sparklemotion/mechanize (last update 05/2026) - Ruby library that makes automated web interaction easy
- https://www.phlex.fun/ - pure Ruby views/templates

### Mail
- https://github.com/ryanb/letter_opener (last update 04/2026) - preview email in the browser instead of sending it during development, avoiding test email delivery setup and accidental sends

### Testing
- https://github.com/bmabey/email-spec (last update 03/2026) - Rails mailer RSpec/Cucumber/MiniTest matchers
  - `UserMailer.send_wellcome(params).should reply_to(addr), deliver_to, deliver_from, bcc_to, cc_to`
  - `have_subject`, `include_email_with_subject`, `have_body_text`, `have_header`
- https://github.com/jnicklas/capybara#drivers (last update 04/2026) - Capybara driver list; capybara-webkit is headless and JS-capable, Poltergeist uses PhantomJS and detects JS errors
- https://github.com/bblimke/webmock (last update 03/2026) - stubbing and expectations for HTTP requests, e.g. when communicating with external APIs
- https://github.com/site-prism/site_prism (last update 06/2026) - Page Object Model DSL for Capybara
- https://github.com/thoughtbot/shoulda-matchers (last update 06/2026) - RSpec/Minitest matchers for common Rails validations, associations, and controller behavior
- https://github.com/thoughtbot/factory_bot_rails (last update 04/2026) - Rails integration for factory_bot test data factories
- https://github.com/minitest/minitest (last update 05/2026) - Ruby testing framework bundled with Ruby and commonly used in Rails projects
- https://github.com/rspec/rspec-rails (last update 06/2026) - RSpec testing framework integration for Rails

### Rails application gems
- https://github.com/heartcombo/devise (last update 06/2026) - flexible authentication solution for Rails based on Warden
- https://github.com/heartcombo/simple_form (last update 04/2026) - Rails form builder with concise DSL and generated markup wrappers
- https://github.com/CanCanCommunity/cancancan (last update 01/2025) - authorization library for Ruby/Rails with a declarative ability DSL
- https://github.com/kaminari/kaminari (last update 02/2026) - scope- and engine-based pagination library for Rails and other Ruby frameworks

### Deployment
- https://github.com/capistrano/capistrano (last update 05/2026) - remote server automation and deployment tool for Ruby applications
- https://github.com/capistrano/bundler (last update 11/2025) - Capistrano plugin for Bundler integration during deploys
- https://github.com/capistrano/rails (last update 12/2024) - Capistrano plugin for Rails-specific deploy tasks such as assets and migrations

### Database adapters
- https://github.com/brianmario/mysql2 (last update 05/2026) - fast MySQL client library for Ruby

### Frontend / assets
- https://github.com/rails/sass-rails (last update 10/2020) - Sass adapter for the Rails asset pipeline
- https://github.com/rails/jquery-rails (last update 10/2025) - jQuery and jquery-ujs adapter for Rails
- https://github.com/jquery-ui-rails/jquery-ui-rails (last update 04/2025) - jQuery UI packaged for the Rails asset pipeline
- https://github.com/rubyjs/therubyracer (last update 12/2023) - embedded V8 JavaScript runtime for Ruby, historically used by Rails asset compilation
- https://github.com/twbs/bootstrap-rubygem (last update 01/2026) - Bootstrap packaged as a Ruby gem for Rails/Sprockets
- https://github.com/willbryant/kaminari-bootstrap (last update unknown) - Bootstrap-compatible pagination views/templates for Kaminari

### Commerce
- https://spreecommerce.org - open-source eCommerce platform giving you full control and customizability
  - https://github.com/spree/spree (last update 06/2026) - Spree Commerce source repository

### Hobby / experiments
- https://github.com/rubiety/jazzity (last update unknown) - web app for exploring jazz theory
- https://deveiate.org/code/linguistics/ - framework for building linguistic utilities

### Unresolved from outdated must-have list
- `hb` - unclear old shorthand; keep unresolved until identified
