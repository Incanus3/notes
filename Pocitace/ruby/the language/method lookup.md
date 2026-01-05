* ruby protected methods
	* can be called inside object (and descendants) with implicit recipient
	* can be called from methods of the same class with explicit recipient
	* can't be called from anywhere else
	* ruby 1.9 - respond_to?(:protected_method) #=> true (!)
	* ruby 2.0 - respond_to?(:protected_method) #=> false, cool, but!

```ruby
class A
  def == a
	puts a.respond_to? :zoom! #=> false despite the fact that we can actually call the method
	puts a.zoom!
  end

  protected
  def zoom!; :a; end
end
```
