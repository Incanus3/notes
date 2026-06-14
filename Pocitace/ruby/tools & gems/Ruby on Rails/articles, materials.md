### Books / courses
- http://pragprog.com/book/rails4/agile-web-development-with-rails - Rails book covering the fundamentals of building web apps with Rails
- http://pragprog.com/book/jvrails2/crafting-rails-applications - book about advanced Rails application patterns and architecture
- http://rails4.codeschool.com/videos - Rails 4 training video course
- http://pragmaticstudio.com/rails - Rails course from Pragmatic Studio
- https://gorails.com - GoRails tutorials, screencasts, and learning resources for Rails developers
- http://www.manning.com/bigg2/ - Rails 4 in Action book

### Official Rails guides
- http://guides.rubyonrails.org/security.html - official Rails security guide
- http://guides.rubyonrails.org/caching_with_rails.html - official guide to caching with Rails
- http://guides.rubyonrails.org/debugging_rails_applications.html#the-logger - Rails debugging guide section about logging
- http://guides.rubyonrails.org/i18n.html - official Rails guide to localization and internationalization
  - setting the locale from domain name
- http://guides.rubyonrails.org/active_record_callbacks.html - official guide to Active Record callbacks
- http://guides.rubyonrails.org/security.html#logging - guide section on filtering sensitive parameters from logs
  - `config.filter_parameters << :password`
- http://guides.rubyonrails.org/active_record_querying.html - guide section on eager loading and query behavior

### Architecture / patterns
- http://cbra.info/ - component-based Rails architecture site
- http://teotti.com/component-based-rails-architecture-primer/ - primer on component-based Rails architecture
- http://teotti.com/gemfiles-hierarchy-in-ruby-on-rails-component-based-architecture/ - article on organizing Gemfiles for component-based Rails apps
- http://blog.sensible.io/2013/08/17/strong-parameters-by-example.html - practical strong-parameters examples for Rails
- http://blog.steveklabnik.com/posts/2011-09-06-the-secret-to-rails-oo-design - Rails OO design article by Steve Klabnik
- http://blog.steveklabnik.com/posts/2011-09-09-better-ruby-presenters - article on better Ruby presenters
- http://words.steveklabnik.com/ - Steve Klabnik’s blog and writing archive
- http://kpumuk.info/ruby-on-rails/simplifying-your-ruby-on-rails-code/ - article about simplifying Rails code
- http://blog.carbonfive.com/2014/01/07/presenters-to-widgets-with-activemodelconversion/ - article about presenters/widgets and non-persisted form objects
- http://quickleft.com/blog/using-faux-activerecord-models-in-rails-3 - article about using non-ActiveRecord objects with `form_for`
- http://cmme.org/tdumitrescu/blog/2014/01/careful-what-you-memoize/ - article about consequences of memoizing at class level
- https://github.com/rails/rails/blob/3-2-stable/activemodel/lib/active_model/secure_password.rb - Rails source example for secure password implementation
- http://api.rubyonrails.org/classes/ActiveModel/Validations/HelperMethods.html#method-i-validates_confirmation_of - documentation for confirmation validation helper
  - adds `<attr>_confirmation` parameter to `Model.create` / `update` and checks it during save
- http://api.rubyonrails.org/classes/ActiveModel/Validations/ClassMethods.html - Rails guide/API reference for validations
- http://bibwild.wordpress.com/2012/03/15/activerecord-concurrency-currently-good-news-and-bad/ - article about ActiveRecord concurrency behavior
- http://blog.arkency.com/2013/05/is-it-cute-or-ugly/ - Arkency post on a Rails design question
- http://blog.arkency.com/2013/07/ruby-and-aop-decouple-your-code-even-more/ - Arkency article on Ruby/AOP and decoupling

### Testing
- http://matthewlehner.net/rails-api-testing-guidelines/ - guidelines for testing Rails APIs
- http://blog.arkency.com/2013/07/coffeescript-tests-for-rails-apps/ - Arkency article about CoffeeScript tests in Rails apps
- http://blog.arkency.com/2013/09/testing-client-side-views-in-rails-apps/ - Arkency article about testing client-side Rails views

### Rails articles / reference
- http://railscasts.com/?type=free - free RailsCasts episodes
- http://railscasts.com/?tag_id=39 - RailsCasts tag for Rails code walkthrough episodes
- http://richonrails.com/articles - archive of Rails articles and tutorials

### Payments / domain-specific
- https://www.petekeen.net/mastering-modern-payments - article on modern payments systems and practices

### Misc / bookmarks
- http://objectsonrails.com/ - Objects on Rails site
