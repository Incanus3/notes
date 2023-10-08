Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-11-19T14:11:00+01:00

====== design flaws ======
Created Tuesday 19 November 2013

* **RETE** has **too many responsibilities **the matching itself + building of the network
	* violation of **SRP**
* -> there should be a RETE** factory** (network builder), which
	* takes facts and rules
		* should not query environment for these, because
			* this **increases coupling** and dependencies in general
			* doesn't make sense - what rete needs is facts and rules, why should it care, that env is the one who has this data
			* tells 'I know what you know, so give me this data' - violates **Demeter**
			* decreases **reusability** - what if I want to use RETE in a different context, where this data goes from two different sources
	* an **observer** (which just happens to be an environment, but rete doesn't care about it, it just knows to notify it about match changes)
		* taking env specificaly again **increases coupling** between those two
		* it also creates cyclic dependency between them - coupling nightmare
		* is a violation of **dependency inversion principle** - depend on abstraction, not concretions
* this is the theory, how does this work in practice?
	* RETE factory - there's no reason to create an actual class for this (as all the state can be kept track of in the functions)
		* classes don't work well as namespaces (function bags) in lisp, since
			* 'self' is just another argument to the methods and there's no actual need for another argument here if there's no state
			* classes don't hide the internal methods - this is the job of packages
	* environment as observer in rete
		* environment is in separate package, so all calls to it have to be qualified (are the symbols imported)
		* so even when rete doesn't care that the observer is actually an environment, it needs to use the exil-env:add-match to notify it, which means it needs to know, that it is an environment
			* => package system makes it hard to use polymorphism (roles, duck types) in large scale
				* calling package needs to know from which package the name is exported
				* packages implementing the polymorphic type need to agree on this package too
					* => there could be special package for this duck type, but then implementor is spread across several packages (is this a problem?)

* https://github.com/Incanus3/ExiL/commit/7ff1a7c694fdc909321559b9114436a1bf2f503e
* chaining several helper methods with same name (each does part of the work) instead of extracting the actual work into reusable methods
* before:
	* (match-against-pattern%%% object pattern atom-matcher) - does the actual matching using atom-matcher, return bindings
	* (match-against-pattern%% object pattern) - polymorphic for fact/pattern as object - provides the correct atom-matcher for %%%
	* (match-against-pattern% object pattern) - calls %%, than removes noise
	* (match-against-pattern object pattern) - calls %, than returns friendly values for higher layer - this is probably ok
* after
	* extracted (atom-matcher object) and (remove-noise bindings)
	* (match-against-pattern% object pattern atom-matcher) - does the actual matching
	* (match-against-pattern object pattern) - calls (remove-noise (match-against-pattern% object pattern (atom-matcher object)), returns friendly values
* advantages
	* atom-matcher and remove-noise are now reusable
	* their names document what they do (unlike the %%%%% helper methods)
		* the point of match-against-pattern%% was to provide atom-matcher
		* the point of match-against-pattern% was to remove-noise
	* similar to composition over inheritance rule
