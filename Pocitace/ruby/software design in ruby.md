- [ ] move non-ruby-specific stuff out
### talks
http://www.youtube.com/watch?v=iUe6tacW3JE - deconstructing the framework
* rails controller terribly violates the single responsibility principle (object should have only one reason to change)
* usual responsibilities: authentication/authorization, wrap http (headers, params, status), manipulate model, manipulate/query database
	present models, create response content, route (redirect), choose content type
* decompose - introduce presenter, db read, db write - entities, http read, http write - controller becomes logic
	* response part handles http write
	* authentication should be route's concern - route should match object x, action (verb) y and state z (e.g. auth status)
* wrappers for external services (good reason for models) - ruby has a culture of fast change without much regard to backward compatibility - you want
	to insulate yourself from their api

http://www.youtube.com/watch?v=uDaBtqEYNBo - Rocky Mountain Ruby 2013 How I architected my big Rails app for success! by Ben Smith
  * avoid cyclical dependencies in rails app (e.g. User <-> Post)
  * use engines to cut monolitic app to pieces - better scalability, easier parallel development

http://www.youtube.com/watch?v=CGN4RFkhH2M - hexagonal architecture with rails
### books
http://www.informit.com/store/practical-object-oriented-design-in-ruby-an-agile-primer-9780321721334
http://www.amazon.com/gp/product/0321603508 - Refactoring - ruby edition

### blog posts
http://blog.steveklabnik.com/posts/2011-09-06-the-secret-to-rails-oo-design
http://blog.steveklabnik.com/posts/2011-09-09-better-ruby-presenters
http://robots.thoughtbot.com/post/14825364877/evaluating-alternative-decorator-implementations-in
- method_missing, Delegator, SimpleDelegator, DelegateClass, or Forwardable