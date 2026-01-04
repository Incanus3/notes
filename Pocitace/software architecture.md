### talks
https://www.youtube.com/watch?v=WpkDN78P884 - uncle bob - architecture: the lost years
 - web is only a delivery mechanism and it's slow
- the web should not be the application's main concern - it's an implementational detail
- don't design your code to fit to a framework,
- defer implementation-specific decisions untill needed
- why do we have a test suite? to be able to refactor with confidence
- you need your tests to run fast - decouple everything, that's slow - web, database

https://www.youtube.com/watch?v=SxDwgbowdOU - glenn vanderburg - real software engineering
https://www.youtube.com/watch?v=v-2yFMzxqwU - sandi metz - SOLID object-oriented design
https://www.youtube.com/watch?v=l780SYuz9DI - jim weirich - the building blocks of modularity
### books
http://www.amazon.com/Working-Effectively-Legacy-Michael-Feathers/dp/0131177052
* instead of supplying several callbacks as procs to a method for handling various result states
  (e.g. payment service object method may result in success or 5 types of failures) or processing all exceptions it may throw (which must be done around every call), you can implement callbacks as methods in the caller and supply self
  * the choice depends on whether the callback handling is always the same
    - if it is, then a method for each situation is ideal
    - if it's not - e.g. three different calls to the service object all can result in the same failures, but the handling code for them needs to differ, then separate handling is needed - either by rescuing exceptions or providing callback procs, etc.
	
http://www.growing-object-oriented-software.com
https://www.amazon.com/Software-Development-Principles-Patterns-Practices/dp/0135974445
### sites
http://sourcemaking.com/ - design patterns, refactoring
### concepts
http://en.wikipedia.org/wiki/Connascence_(computer_programming)
http://en.wikipedia.org/wiki/Law_of_Demeter
### people
http://sandimetz.com/