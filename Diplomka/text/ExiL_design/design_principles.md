Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-11-19T14:10:36+01:00

====== design principles ======
Created Tuesday 19 November 2013

* **SOLID**
	* **SRP**
	* **open/closed** - entities should be open for extension, closed for modification
		* allow change in behavior without changing the source (subclassing/inclusion with hook methods overriding, supplying block to call, etc.) -> easily reusable without need to change
	* **Liskov substitution principle** - objects should be replacable by their subtypes (strong //is a// relationship)
	* **Interface segregation principle** - many client-specific interfaces are bettern than one general-purpose interface
		* no client should be forced to depend on methods it doesn't use
	* **Dependency inversion principle** - depend upon abstractions, not concretions
		* high-level modules shouldn't depend on low-level modules, both should depend on abstractions
		* abstractions shouldn't depend upon detials, details should depend upon abstractions
* **depend upon entities, that change less than you**
* **Law of** **Demeter** - communicate only with direct neighbors (method chains may signalize violation)
