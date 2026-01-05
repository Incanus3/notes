http://guides.rubyonrails.org/testing.html

https://github.com/rspec/rspec-rails
https://github.com/thoughtbot/shoulda-matchers
https://github.com/jnicklas/capybara

https://github.com/fredwu/api_taster - visually testing Rails APIs

https://github.com/bmabey/database_cleaner - when testing js requests (e.g. by Capybara), you can't use transactional fixtures because the webserver runs in separate process that can't access the database when transaction is open in the test process, which leads to lock
http://fredwu.me/post/61571741083/protip-faster-ruby-tests-with-databasecleaner-and

http://stackoverflow.com/questions/8956816/comprehensive-guide-on-testing-rails-app
https://leanpub.com/everydayrailsrspec

http://gaslight.co/blog/6-ways-to-remove-pain-from-feature-testing-in-ruby-on-rails
http://re-factor.com/blog/2013/09/27/slow-tests-are-the-symptom-not-the-cause/

guard-livereload - reload browser when files change

- spec type inference from path disabled by default, enable it using
```ruby
RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
end
```

- or use metadata explicitly
```ruby
RSpec.describe ThingsController, type: :controller do
  # Equivalent to being in spec/controllers
end
```

- mock_model and stub_model extracted into rspec-activemodel-mocks

- define methods for mock controller in controller specs
https://relishapp.com/rspec/rspec-rails/v/3-0/docs/controller-specs/anonymous-controller

### mocks
RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
- will check when mocking/stubbing a method, that it actually existed
expect(MyClass).to receive(:some_message)
- or use instance_double, class_double and object_double explicitly
https://relishapp.com/rspec/rspec-mocks/v/3-0/docs/verifying-doubles
