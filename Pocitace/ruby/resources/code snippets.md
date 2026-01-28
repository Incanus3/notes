* checking index out of bounds
> [1,2,3][5]
=> nil
> [1,2,3].fetch(5)
IndexError: index 5 outside of array bounds: -3...3
from (pry):4:in `fetch'

* Hash#fetch(key,:not_found) - use when there can be nil as a value

* memoizing fibonacci implementation
'''
class Fixnum
  def fib
    @fib ||= (self-1).fib + (self-2).fib
  end
end
[0,1].each { |i| i.instance_eval { @fib = i } }
42.fib #=> 267914296
'''
* bohuzel uz nefunguje - Fixnum je frozen

* map nad iteratorem
SIZE.times.map { Array.new(SIZE) }


* when several modules are included, you can use super to delegate to method defined in the previous modules
* Object#tap(&block) - peform operation on the value, and than return it
'''
(1..10)                .tap {|x| puts "original: #{x.inspect}"}
  .to_a                .tap {|x| puts "array: #{x.inspect}"}
  .select {|x| x%2==0} .tap {|x| puts "evens: #{x.inspect}"}
  .map { |x| x*x }     .tap {|x| puts "squares: #{x.inspect}"}
'''
* delegate
'''
class MyClass
  delegate :mehod,:another,:to => :something

  def something
    return :the_dalagatee
  end
end
'''
