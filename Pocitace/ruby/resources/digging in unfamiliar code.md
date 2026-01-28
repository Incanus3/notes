- `bundle open <gem>` - open the gem in editor
- `Kernel.caller` - returns calling  backtrace
- `object.method(:name).source_location`

```ruby
self.class.ancestors.each do |klass|
  next unless klass.method_defined?(:method)
  puts klass.instance_method(:method).source_location
end
```