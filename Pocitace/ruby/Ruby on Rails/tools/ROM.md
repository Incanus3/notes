== Registry ==
- includes Enumerable
- delegates each to elements
- interprets methods with name present as key in elements as elements[name] access
- what subclasses this?
  - RelationRegistry

== Options ==
- simplifies attibute population from hash during construction:
class User
  include Options

  option :name, type: String, reader: true
  option :admin, allow: [true, false], reader: true, default: false

  def initialize(options={})
    super
  end
end

user = User.new(name: 'Piotr')
user.name # => "Piotr"
user.admin # => false

== ClassMacros ==
- defines 'defines' macro used for class-level settings
class MyClass
  extend ROM::ClassMacros

  defines :one, :two

  one 1
  two 2
end

class OtherClass < MyClass
  two 'two'
end

MyClass.one # => 1
MyClass.two # => 2

OtherClass.one # => 1
OtherClass.two # => 'two'

== Plugin ==
- holds module and options, Plugin#apply_to(klass) includes module in class

== Plugins::Relation::RegistryReader ==
- adds class option __registry__
- defines method_missing to interpret unknown methods as registry fetches