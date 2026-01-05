http://pragprog.com/book/rails4/agile-web-development-with-rails
http://pragprog.com/book/jvrails2/crafting-rails-applications
http://rails4.codeschool.com/videos
http://pragmaticstudio.com/rails
https://gorails.com

http://guides.rubyonrails.org/security.html
http://guides.rubyonrails.org/caching_with_rails.html
http://guides.rubyonrails.org/debugging_rails_applications.html#the-logger
http://guides.rubyonrails.org/i18n.html - localization of rails apps
	* setting the locale from domain name
http://guides.rubyonrails.org/active_record_callbacks.html

http://guides.rubyonrails.org/security.html#logging - filter logging of secure parameters (password, etc)
* config.filter_parameters << :password

http://guides.rubyonrails.org/active_record_querying.html - eager loading

https://www.petekeen.net/mastering-modern-payments
http://blog.sensible.io/2013/08/17/strong-parameters-by-example.html
http://matthewlehner.net/rails-api-testing-guidelines/

http://blog.arkency.com/ - great, mostly Rails, blog
http://blog.arkency.com/2013/05/is-it-cute-or-ugly/
http://blog.arkency.com/2013/07/ruby-and-aop-decouple-your-code-even-more/
http://blog.arkency.com/2013/07/coffeescript-tests-for-rails-apps/
http://blog.arkency.com/2013/09/testing-client-side-views-in-rails-apps/
http://bibwild.wordpress.com/2012/03/15/activerecord-concurrency-currently-good-news-and-bad/

https://github.com/rails/rails/blob/3-2-stable/activemodel/lib/active_model/secure_password.rb
http://api.rubyonrails.org/classes/ActiveModel/Validations/HelperMethods.html#method-i-validates_confirmation_of
- adds <attr name>_confirmation parameter to Model.create, update that is
  checked against attribute during save
http://api.rubyonrails.org/classes/ActiveModel/Validations/ClassMethods.html - obecne (flexibilni) validatory

http://blog.steveklabnik.com/posts/2011-09-06-the-secret-to-rails-oo-design
http://blog.steveklabnik.com/posts/2011-09-09-better-ruby-presenters
http://words.steveklabnik.com/

http://www.manning.com/bigg2/ - Rails 4 in action

http://kpumuk.info/ruby-on-rails/simplifying-your-ruby-on-rails-code/

http://railscasts.com/?type=free
http://railscasts.com/?tag_id=39 - rails code walkthrough episodes - **this is why i should subscribe**

http://objectsonrails.[[http://objectsonrails.com/#|com/]]

http://blog.carbonfive.com/2014/01/07/presenters-to-widgets-with-activemodelconversion/
- create a non-persisted model class (i.e. form object, presenter), that can be
  rendered directly using render @object

http://quickleft.com/blog/using-faux-activerecord-models-in-rails-3
- create non ActiveRecord object, that can be used with form_for
- so you can use form_for for non-model forms (like search queries) and don't have to use form_tag

http://cmme.org/tdumitrescu/blog/2014/01/careful-what-you-memoize/ - consequences of memoization at class level

http://richonrails.com/articles
