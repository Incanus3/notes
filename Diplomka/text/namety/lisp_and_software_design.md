Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-11-16T20:08:29+01:00

====== lisp and software design ======
Created Saturday 16 November 2013

* overlaps with top-down X bottom-up topic
* Lisp is great symbolic manipulation programming tool, thus a great choice to program AI in, but it's a 40 years old language
* it's multiparadigmatic (said to have absorbed all the paradigms that have come along - citation needed), but is it still true? - is it a good OOP language?
	* (consider real advantages of OOP in context of lisp - lisp has many other constructs for making abstraction barriers)
	* **CLOS, methods as generics, lambda list congruence** - ignorance to roles - the fact that 2 objects have a method of same name doesn't mean, that this is a polymorphic method intended to handle the same message (with forced lambda list congruence it kind of does)
	* **module mixins vs. multiple inheritance**
		* only single inheritance (and maybe Java-like interfaces) are clearly not enough, but is mutliple inheritance a good solution?
		* in Ruby - clear distinction between
			* module inclusion - mixin - 'acts as role' relationship, and
			* inheritance - strong 'is a' relationship
		* in Lisp - only multiple inheritance
	* **package system, export-import instead of public/private**
		* encourages layers over coherent, encapsulated objects
		* every call to a foreign function/method needs to be qualified, whereas in other OO languages, we only need to name the class when creating the instance, then we call methods on it and don't care about the name of the class (or the enclosing module) any more
			* or the names can be imported
				* selectively - tedious
				* all at once - likely colisions (also because of how methods are implemented - methods of different classes clash with each other)
    * dynamic calling of methods (symbol-append) - in OO languages, methods is identified by name and receiver (sometimes params), in lisp, I also need to know package
	* **lisp 'standard library' functions aren't methods** (even though you can create methods for built-in types) -> can't be polymorphized - equality, +, append, etc.
		* concat - takes type of the result - is this ok? could this be done better?

* CLOS and SRP - classes are open, methods aren't bound to specific class -> SRP for classes not very relevant, but can be applied to functions and packages
