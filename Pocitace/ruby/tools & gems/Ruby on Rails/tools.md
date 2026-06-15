### API
- https://github.com/rails-api/rails-api (last update 05/2021) - generators for API-only Rails apps with unnecessary modules and Rack middleware removed.

### Views / forms / UI
- http://builder.rubyforge.org/ - Ruby XML builder.
- http://haml.info/tutorial.html - Haml tutorial for HTML templating.
- https://github.com/slim-template/slim (last update 05/2026) - Haml alternative with a compact template syntax.
- https://www.ruby-toolbox.com/categories/rails_form_builders - Ruby Toolbox category for Rails form builder gems.
- http://foundation.zurb.com/docs/ - Foundation docs for grid/page layout.
- https://github.com/michelson/lazy_high_charts (last update 02/2023) - Highcharts integration for Rails/Ruby apps.

### Controllers / CRUD
- https://github.com/plataformatec/responders (last update 04/2026) - additions to `respond_with`: flash, redirect location, cache, collection.
- https://github.com/josevalim/inherited_resources (last update 06/2026) - conventions for DRY Rails CRUD controllers.
- https://www.petekeen.net/dry-your-rails-crud-with-simple-form-and-inherited-resources - article on DRYing Rails CRUD with Simple Form and inherited_resources.

### Databases / migrations
- https://github.com/TalentBox/sequel-rails (last update 04/2025) - use Sequel from Rails apps.
- http://fredwu.me/post/58910814911/gotchas-in-the-ruby-sequel-gem - gotchas when using the Sequel gem.
- https://github.com/zdennis/activerecord-import/ (last update 04/2026) - save ActiveRecord records in batch.
- http://www.amberbit.com/blog/2014/2/4/postgresql-awesomeness-for-rails-developers - PostgreSQL features useful for Rails developers.
- https://github.com/jasonfb/nondestructive_migrations (last update 10/2021) - deprecated migration helper, replaced by `jasonfb/nonschema_migrations`.

### Design patterns / architecture
- https://github.com/drapergem/draper (last update 05/2026) - decorators/view-models for Rails apps.

### Development helpers / debugging
- https://github.com/charliesome/better_errors (last update 07/2024) - better error pages for Rails/Sinatra/Rack apps.
  - Click file name link in code frame to open editor, should work with gem files too.
    - To customize editor, add initializer with `BetterErrors.editor = ...` (if `BetterErrors.defined?`).
  - Visit path `__better_errors` to show the last occurred exception, including JavaScript ones.
- https://github.com/dejan/rails_panel (last update 05/2026) - Chrome web development addon with a helper gem for Rails.
- https://github.com/JoshCheek/seeing_is_believing (last update 03/2026) - annotates Ruby source with outputs from individual lines.
- https://github.com/cldwalker/hirb (last update 02/2024) - table/tree/menu views for IRB console output.
- https://github.com/janlelis/irbtools (last update 12/2025) - improvements and helpers for Ruby IRB.
- https://github.com/ctran/annotate_models (last update 08/2024) - adds schema/routes comments to Rails models and other classes.
- https://github.com/evrone/quiet_assets (last update 06/2021) - deprecated helper for suppressing asset pipeline request logs.

### Admin interfaces
- https://github.com/sferik/rails_admin (last update 09/2025) - Rails engine for admin CRUD interfaces.

### Code quality / metrics
- https://github.com/troessner/reek (last update 06/2026) - code smell detector for Ruby.

### Authentication
- https://github.com/plataformatec/devise (last update 06/2026) - flexible authentication solution for Rails with Warden.
- https://github.com/plataformatec/devise/wiki - Devise wiki.
- http://rubydoc.info/github/plataformatec/devise/master/frames - Devise API documentation.
- https://github.com/plataformatec/devise/wiki/Example-Applications - Devise example applications.
- http://railscasts.com/episodes/209-introducing-devise - RailsCast introducing Devise.
- http://railscasts.com/episodes/210-customizing-devise - RailsCast on customizing Devise.

### Authorization
- https://github.com/ryanb/cancan (last update 12/2021) - authorization gem for Rails; defines which users can access which resources.
  - Expects `current_user` method in controller, usually on top of Devise.
  - Very good DSL: expressive and simple.
  - https://github.com/ryanb/cancan/wiki/defining-abilities
  - https://github.com/ryanb/cancan/wiki/Role-Based-Authorization
  - https://github.com/RailsApps/rails3-bootstrap-devise-cancan (last update 07/2022) - outdated Rails 3 example app combining Bootstrap, Devise, and CanCan.

### Search
- https://github.com/activerecord-hackery/ransack (last update 05/2026) - object-based search forms for ActiveRecord.
