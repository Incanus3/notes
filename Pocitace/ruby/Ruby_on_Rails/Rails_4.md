Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-11-18T15:20:51+01:00

====== Rails 4 ======
Created Monday 18 November 2013

=== ActiveRecord ===
* Model.find_or_initialize_by(hash), Model.find_or_create_by(hash)
* record.update(hash) - replaces update_attributes
* record.update_columns(hash) - simply builds and executes SQL -> skips validation, callbacks, etc.
* Model.scoped is deprecated, use Model.all instead (doesn't run query, returns Relation -> chainable)
* use Model.none to return empty relation
* use Post.where.not(author: author) instead of Post.where('author != ?', author)
	* when author.nil?:
		* Post.where('author != ?', author) => SELECT * FROM posts WHERE (author != NULL) - wrong
		* Post.where.not(author: author) => SELECT * FROM Posts WHERE (author IS NOT NULL)
'''

class User < ActiveRecord::Base
  default_scope { order(:name) }
end
'''

* Rails 3 appends subsequent conditions:
	* User.order('created_at DESC') => SELECT * FROM users ORDER BY **name asc, created_at desc**
* Rails 4 prepends them:
	* User.order('created_at DESC') => SELECT * FROM users ORDER BY **created_at desc, name asc**

* Rails 4 - order takes hash: User.order(created_at: :desc) or User.order(:name, created_at: :desc)
* Post.includes(:comments).where("comments.name = 'foo'") - deprecated - rails must analyze the string to find out you're referencing a table from a string, use
* Post.includes(:comments).where("comments.name = 'foo'").references(:comments)
* or Post.includes(:ocmments).where(comments: { name: 'foo' })
* or Post.includes(:comments).where('comments.name' => 'foo')

* Post.includes(:comments).order('comments.name') - doesn't need .references either

=== ActiveModel ===
* rails 3:

''class SupportTicket''
''  include ActiveModel::Conversion''
''  include ActiveModel::Validations''
''  extend ActiveModel::Naming''

''  attr_accessor :title, :description''

''  validates_presence_of :title''
''  validates_presence_of :description''
''end''

* behaves like ActiveRecord model:
	* form_for(@support_ticket)
	* SupportTicket.new(support_params)
	* @support_ticket.valid?, .errors, .to_param
* rails 4 - include only ActiveModel::Model

=== Session ===
* rails 4 not only signs, but also encrypts cookies
* the key can be found in config/initializers/secret_token.rb, e.g.
	* Objednavky::Application.config.secret_key_base = 'lksadlkfjljlaksjdflkjasldkfjlksajdfoijyxcimalkewrjyxlijv'
* flash types
	* built in - notice, alert - can just call notice instead of flash[:notice], can use with redirect_to
	* custom:
		* (in controller:) add_flash_types :test -> can just call test instead of flash[:test], can use with redirect_to

=== Views ===
Owner has_many :items
Item belongs_to :owner
* Rails 3 & 4: collection_select(:item, :owner_id, Owner.all, :id, :name) #=> params[:item][:owner_id] = owner.id
* Rails 4: collection_radio_buttons(...), collection_check_boxes(...)

* Rails 3 & 4: f.date_select :return_date - ugly form, ugly HTML - uses 3 params
* Rails 4: f.date_field :return_date - single param (not supported by bootstrap_forms)

* Rails 3 & 4: JBuilder template builder - e.g.:
'''
json.array!(@owners) do |owner|
  json.extract! owner, :name
  json.url owner_url(owner)
end
'''

* Rails 4: ruby template handler - write pure ruby, return value is used - e.g.:
'''
owners_hashes = @owners.map do |owner|
  { name: owner.name, url: owner_url(owner) }
end
owners_hashes.to_json
'''
