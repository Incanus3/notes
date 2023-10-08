Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-11-16T19:09:02+01:00

====== top-down X bottom-up & TDD x BDD ======
Created Saturday 16 November 2013

* BDD is actually not, what I want to talk about here, the main interest lies in top-down X bottom-up design and layered architecture X high cohesion objects (with single responsibility, small interfaces, ...) - basically 'is lisp a good OO language? -> merge with 'lisp and software design topic'

http://en.wikipedia.org/wiki/Behavior-driven_development
http://dannorth.net/introducing-bdd/

[ ] find out more about lisp and TDD, BDD in general
[ ] citations
	* top-down and bottom-up design (ideally some of upol materials)
	* Lisp and TDD
	* TDD x BDD
	* OOP

* motivation for including this in the thesis - I've been programing the software for several years, during which I've had various programming experiences (including **TDD and BDD**) and have quiet improved my skills, because of this, the code was vastly rewritten several times when I noticed design flaws (or have been iritated by them enough to do it) as my skills improved
* I have, probably unintentionally (realy? did functional programming courses encoureged this style?), chosen **bottom-up design style**
* I may (or not) have designed the application better, if I've chosen a **top-down** **style**
* applied to the application
	* it would be interesting to recapitulate and analyze the design flaws I've observed and how hard/possible was it to fix them
		* good design encourages ease of change (not to mention reusability (-> maintainability), reasonability - small change in requirements (-> maintainability), exemplarity - flaws don't propagate (-> maintainability)
	* it would be interesting to analyze, which of these flaws could be prevented by **top-down design style**, which isn't very idiomatic in Lisp (realy? or is it just our department?)


* bottom-up
	* think about the basic tools you'll need to build this kind of application
	* build them (functional - no side-effect - you don't know what context these will be used in; easy to test separately - **TDD**) thus bringing the language closer to the application aim
	* think about the next, more application-specific layer and repeat the process
	* until you suddenly realize, that you've just built the top-level layer (this is quite a usual experience when building projects this way)
	* works great for small projects, but for larger ones, you rarely know good enough, what tools you'll need
	* this style forces you to make many decisions too soon, when you don't have enough information to make them right
* top-down
	* start at the outer layer, think about use-cases, messages to be sent
	* find out, what entities interact with each other on the upper-most level
	* mock the underlying complexities (-> still can be done **TDD**), outline the structure
	* than zoom in to some specific (isolated) area and repeat the process
	* -> build just what you need (high business value)
	* -> don't think about layers, but about isolated entities and messages between tem (which is hard to do bottom-up - you can think about the **layer** you're gonna need to get up, but not exactly about the entities, cause you haven't thaught about the app from the outer point of view) -> more OO

* testing motivation - lisp is a dynamic language -> more run-time errors, need to ensure all parts of code have been run
	* functional style - referential transparent code is easy to test (which is one of its biggest advantages - build small, orthogonal parts, test them thoroughly in isolation, than combine them into more complex parts)
	* test-driven code tends to be more isolated (functional -> referentially transparent)
	* this is the TDD aspect - TDD doesn't enforce top-down or bottom-up
* tests
	* specification (know problem domain, know when you solved the problem)
	* feedback -> fast cycle (don't write ton of code, than start running it and drawn in the bugs on integration level)
	* regression -> once it works, it continues to work (because of feedback)
	* last 2 -> confidence
* TDD ⊂ BDD
* readability - BDD - high - count.should be(5) - writing tests from the customer's point of view
* granularity - how much info do I have when this test fails? how often do I need to change the test (test X spec - specifications shouldn't change that often)
	* unit tests
		* very much info
		* too bound to implementation (as opposed to behavior) -> quickly become obsolete, or are too costly to maintain
	* integration/acceptence/feature
		* works more like a specification (acceptance feedback) - tests should still be passing when the implementation changes if the requirements haven't changed
* non-BDD TDD (mainly unit testing) - often only one cycle - no zooming out after each inner cycle
	* -> drives the design to reusability of the basic entities, but not the overall design of combining them
	* -> drives to the layering strategy - build the lower level, unit test it, then once you move to the higher level, the lower layer is part of the language, you again 'unit test' these higher level entities - this is actually an integration test from the overall perspective (since you already build on the underlying entities) but the integration comes too late - after you built the entities - and if you find out they don't play very well together, it will be very costly to change the 'completed' lower layer
* -> BDD implies top-down design
	* better acceptance feedback -> know you're getting closer to solving the overall problem, be focused on it, don't get diverted by implementing too much
	* better integration feedback -> know your domain objects play well together
	* better design - focus on messages instead of units of functionality
		* messages (and polymorphism) are central to OOP
			* OOP is good for big (real world) projects - high reusability, division of concerns, Sandi Metz - 'you can't keep your whole application in mind, but you can learn not to care' - it doesn't matter if each entity plays well with its direct neighbors)
		* you can better identify the entities that interact in your domain if you look from outside in
		* otherwise you observe that you need some functionality and you just write all the functions you think you could need in an incoherent blob

* overlap with other problem - lisp package system, symbols, exporting & importing vs public/private -> **layers** instead of objects
