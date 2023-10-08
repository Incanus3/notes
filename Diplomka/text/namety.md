Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-11-16T19:08:37+01:00

====== namety ======
Created Saturday 16 November 2013

=== vztah odvozovani v expertnim systemu a matematicke logiky ===
	* znalostni baze - teorie
	* pravidla jako implikace
	* v LHS pravidla - konjunkce, negace
	* disjunkce - nova definice pravidla
	* RHS - "cisty expertni system" - jen formule
		* ExiL - jakekoli s-vyrazy

=== slozitost s equalitou a kopirovanim slozenych (hloubkovych) struktur - neni zadny obecny hloubkovy nastroj ===
* vetsina jazyku ma nastroj na vytvoreni bytecopy, coz by bylo ve vetsine pripadu dostatecne
* podobne vetsina jazyku ma rozumne defaulty na ekvivalenci objektu ruznych typu (i uzivatelskych - typicky jsou ekvivalentni, kdyz maji vsechny sloty stejne hodnoty)
* dilemma s vlastni implementaci - znacna casova investice, koncovy uzivatel v podstate nepotrebuje, je ale temer nutne pro rozumne testovani
	* pro velkou cast objektu neni kopirovani potreba, nebot se s nimi pracuje jako s immutable (templaty, fakta, patterny, pravidla, fact-groups matche (neni uplne jiste - match drzi token, ktery je linked-listem udrzovanym hierarchii uzlu rete - mozna se muze v case menit - zajistit v takovem pripade kopirovani pri vystupu z rete - pak by byl immutable)
* funkcionalni paradigma vs. efektivita - kdybych mel vsechny funkce nedestruktivni (musel bych pochopitelne vsude implementovat kopirovani)
	* nemusel bych se o kopirovani starat na urovni uzivani objektu -> mensi chybovost
	* ale pametove naroky by byly enormni
	* navic i kodu by znacne pribylo

* lisp as a dynamic language - **introspection**, MOP (ease of use, standardization, does anyone use it?) - compare with modern languages

* **code expressivity and readability - Lisp macros vs. modern metaprogramming techniques, DLSs**
	* macros are powerfull, but hard do do right, error prone and often too much work
	* compare their power and complexity with modern tools used to create new constructs
		* ruby metaprogramming
		* blocks - iteration, mapping, delayed/conditional/repeted execution
		* syntactic sugar - 1 + 2 = 1.+(2)
		* instance_eval, class_eval, singleton_class, self, ...
    * DSLs - include interesting examples - Parslet, rake, rails routes, ...
	* macros are one of the main arguments for lisp prefix notation (which isn't principially bad, but isn't very expressive - e.g. (gethash key hash) vs. hash[key]
	* **application** - rule activations are now saved as symbolic expressions and are evaluated (by eval) in a different environment, which leads to various kinds of strange behavior (see tests), with e.g. ruby block and instance_eval, this could be easily overcome

* **LISP and OOP design**
  * which oop practices are hard to do in CL, how and what do we lose?
    * packages vs public/private methods + method lambda list congruence -> layers over objects
    * modules and mixins - roles (only is-a relationship, no acts-like one)
    * std functions aren't generics
  * top-down vs bottom-up
  * macros vs modern metaprogramming and dynamic techiques
  * tdd

* **slime X LispWorks comparison**
  * asdf/quicklisp behaves strangely - as if macros weren't expanded or even defined
  * intern - for some reason, in sbcl (symbol-append "copy-" slot) worked correctly, but in LW it was interned in different package (exil) - examine further

* expert system, where to find the desired answer, we need to apply first fact/rule in one step and second fact/rule in next step (by given strategy)
  * forward chaining won't find the answer, but backward chaining should
