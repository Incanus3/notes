### Resources

#### Rails / ActiveRecord
- https://api.rubyonrails.org/classes/ActiveRecord/Aggregations/ClassMethods.html - ActiveRecord aggregations API documentation.
- http://blog.plataformatec.com.br/2013/02/active-record-scopes-vs-class-methods/ - discussion of ActiveRecord scopes versus class methods.

#### Query performance / eager loading
- http://blog.codeship.com/speed-up-activerecord - article on speeding up ActiveRecord queries.
- http://robots.thoughtbot.com/active-record-eager-loading-with-query-objects-and-decorators - article on eager loading with query objects and decorators.
- https://github.com/salsify/goldiloader (last update 03/2026) - automatic eager loading for Rails associations.
- https://github.com/flyerhzm/bullet (last update 06/2026) - detects N+1 queries, unnecessary eager loading, and missing counter caches.

#### Hierarchies
- https://github.com/mceachen/closure_tree (last update 05/2026) - adds hierarchy/tree support to ActiveRecord models.

#### Arel
- http://robots.thoughtbot.com/using-arel-to-compose-sql-queries - article on composing SQL queries with Arel.
- http://pivotallabs.com/using-arel-to-build-complex-sql-expressions - article on building complex SQL expressions with Arel.
- https://www.youtube.com/watch?v=ShPAxNcLm3o - RailsConf 2014 talk: Advanced Arel: When ActiveRecord Just Isn't Enough.
- https://github.com/camertron/arel-helpers (last update 11/2025) - helpers for constructing database queries with ActiveRecord and Arel.
- http://www.scuttle.io/ - SQL and Arel editor.
- http://rdoc.info/github/rails/arel - Arel API docs; lists classes and methods, usually without comments.
- http://jpospisil.com/2014/06/16/the-definitive-guide-to-arel-the-sql-manager-for-ruby.html - guide to Arel as SQL manager for Ruby.

### Columns
- `Model.column_names`
- `Model.columns_hash`

```ruby
Order.columns_hash["pay_type"]
# => #<ActiveRecord::ConnectionAdapters::SQLite3Column:0x00000003618228
# @name="pay_type", @sql_type="varchar(255)", @null=true, @limit=255,
# @precision=nil, @scale=nil, @type=:string, @default=nil,
# @primary=false, @coder=nil>
```

Special columns:
- `created_at`, `created_on`, `updated_at`, `updated_on` - automatically updated.
- `id` - primary key, assigned with `save` / `create`.
- `xxx_id` - foreign key.
- `<table>_count` - counter cache for table.

### Associations
- `has_one`, `has_many`, `belongs_to` (foreign key here).
- `has_and_belongs_to_many`.
- Rails implements many-to-many associations using an intermediate join table.
  - This contains foreign key pairs linking the two target tables.
  - ActiveRecord assumes that the join table’s name is the concatenation of the two target table names in alphabetical order.
- You need to create a model for the join table with two `belongs_to` relationships if you want to store additional information, e.g. amount of purchases.

### Constructors
- `new` creates an in-memory instance.
- `create` persists immediately.
- Constructors take hashes or arrays of hashes.
- No local variables.

```ruby
Order.new do |o|
  o.name = "Dave Thomas"
  # ...
  o.save
end
```

```ruby
Order.new(
  name: "Dave Thomas",
  email: "dave@example.com",
  address: "123 Main St",
  pay_type: "check"
).save
```

### Reading data

#### Finders
- `find` - takes one or more primary keys; raises `ActiveRecord::RecordNotFound` if any key is not found.
- `where`
  - Takes a string with conditions and optional wildcards, substituting subsequent arguments.
    - `?` - substitutes in order of appearance.
    - Symbols - substitute from hash.
  - Or just a hash, where keys correspond to columns.
  - `LIKE` example: `User.where("name like ?", params[:name] + "%")`.
  - Returns `ActiveRecord::Relation`.
- `find_by_sql` - takes string and possible wildcards; returns `ActiveRecord::Relation`.

#### Relation introspection
- `attributes()` - hash.
- `attribute_names()` - list.
- `attribute_present?()` - boolean.

#### Subsetting / relations
- `ActiveRecord::Relation` supports `first`, `last`, `all` (`to_a`) and implements `each`, `map`, etc. by calling `all()` first.
- Query does not get evaluated until one of these is used; it can be further modified by scopes, modifiers, etc.
- Modifiers:
  - `order`
  - `limit`
  - `offset` - used with `limit` to get chunks of the set.
  - `select` - only specific columns.
  - `joins` - inserted into SQL immediately after the model table name and before any conditions.
  - `readonly` - object cannot be stored back; automatically applied when `joins` or `select` is used.
  - `group`
  - `lock` - takes optional engine-specific string; otherwise default exclusive lock is obtained.
- Statistics:
  - `average`, `maximum`, `minimum`, `sum` - take a column name; may be combined with `group`, otherwise return single result.
  - `count`.

#### Scopes
- Make method chains called on `ActiveRecord::Relation` reusable.
- Take a name and a function.

#### Reloading data
- When the database is accessed by multiple processes/threads, in-memory instances may become stale.
- `reload()` updates attributes from the database.
- Or use a transaction.

### Updating data
- `save()` - returns true/false.
- `save!()` - raises exception.
- `update()` - takes a hash and saves immediately.
- `create` - always returns an ActiveRecord instance, possibly invalid/non-persisted.
- `create!` - raises exception if invalid.
- Class methods:
  - `update(id, hash)` or list of IDs and hashes; with lists, returns array.
  - `update_all()` on model or dataset.

### Deleting data
- Class methods:
  - `delete(id / list of ids)` - bypasses validations and callbacks.
  - `destroy(id / list of ids)`.
  - `delete_all(conditions)` - bypasses validations and callbacks.
  - `destroy_all(conditions)`.
- Instance methods:
  - `destroy` - deletes from database and freezes the object.
