http://yonkeltron.com/blog/2010/05/13/creating-a-ruby-dsl/
http://www.confreaks.com/videos/57-mwrc2009-jive-talkin-dsl-design-and-construction

http://ms-ati.github.io/docile/ - tool to write internal DSLs in ruby
### creating internal DSLs manually
* singleton pro konfiguraci
```ruby
module AccessControl
  extend self

  def configure(&block)
    instance_eval(&block)
  end

  def definitions
    @definitions ||= {}
  end

  # Role definition omitted, replace with a stub if you want to test
  # or refer to Practicing Ruby Issue #4
  def role(level, options={})
    definitions[level] = Role.new(level, options)
  end

  def roles_with_permission(permission)
    definitions.select { |k,v| v.allows?(permission) }.map { |k,_| k }
  end

  def [](level)
    definitions[level]
  end 
end
```

* singleton pro definici extenzi
```ruby
Turbine::Application.extension(:start_command) do
  def start
    timer = Turbine::Timer.new
    if timer.running?
      prompt.say "Timer already started, please stop or rewind first"
    else
      timer.write_timestamp
      prompt.say "Timer started at #{Time.now}"
    end
  end
end
```

```ruby
module Turbine
  class Application
    def self.extensions
      @extensions ||= {}
    end

    def self.extension(key, &block)
      extensions[key] = Module.new(&block) # def start ... se vyhodnoti v novem modulu
    end

    def initialize
      self.class.extensions.each do |_, extension|
        extend(extension) # kazda nova instance dostname funkcionalitu vsech definovanych extensionu
      end
    end

    def run(command)
      send(command)
    end
  end
end
```
### Parslet - creating external DSLs
http://kschiess.github.io/parslet/ - tool to write parsers in ruby - define grammars with rules, annotate parts of input by symbols -> returns nested hash/array/string structure; define transformations on this structure

=== rules with annotation ===
 - as(name)
```ruby
class MiniP < Parslet::Parser
  # Single character rules
  rule(:lparen)     { str('(') >> space? }
  rule(:rparen)     { str(')') >> space? }
  rule(:comma)      { str(',') >> space? }

  rule(:space)      { match('\s').repeat(1) }
  rule(:space?)     { space.maybe }

  # Things
  rule(:integer)    { match('[0-9]').repeat(1).as(:int) >> space? }
  rule(:identifier) { match['a-z'].repeat(1) }
  rule(:operator)   { match('[+]') >> space? }
  
  # Grammar parts
  rule(:sum)        { integer.as(:left) >> operator.as(:op) >> expression.as(:right) }
  rule(:arglist)    { expression >> (comma >> expression).repeat }
  rule(:funcall)    { identifier.as(:funcall) >> lparen >> arglist.as(:arglist) >> rparen }
  
  rule(:expression) { funcall | sum | integer }
  root :expression
end

require 'pp'
pp MiniP.new.parse("puts(1 + 2 + 3, 45)")
# prints:
{:funcall=>"puts"@0,
 :arglist=>
  [{:left=>{:int=>"1"@5},
    :op=>"+ "@7,
    :right=>{:left=>{:int=>"2"@9}, :op=>"+ "@11, :right=>{:int=>"3"@13}}},
   {:int=>"45"@16}]}
```

===  interpretation ===
```ruby
class SimpleTransform < Parslet::Transform
  rule(funcall: 'puts', arglist: sequence(:args)) {
    "puts(#{args.inspect})"
  }
  # ... other rules
end

tree = {funcall: 'puts', arglist: [1,2,3]}
SimpleTransform.new.apply(tree) # => "puts([1, 2, 3])"
```