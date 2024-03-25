* integration test by mel testovat vystup facts a ne pouzivat eenv::find-facts - pouzit with-output-to-string
* udelat "integration test" na urovni prostredi - nastavit prostredi rucne jako v tst-rete-copy, provest kroky, zkontrolovat finalni objekt jako v integration testech
* test ekvivalence kopie prostredi
	* vyjit z tst-rete-copy, zadefinovat objekty, provest krok vypoctu, pak zkopirovat prostredi a pokracovat ve vypoctu
* test ekvivalence kopie rete objektu
	* obecny test ekvivalence je velice netrivialni, nebot uzly mohou mit napr. deti v jinem poradi - nelze se zanorovat do obou siti stejne a testovat ekvivalenci 1:1
	* pokud predpokladame, ze by objekty mely byt stejne vcetne poradi dedi, lze testovat nasledne:
		* linearizovat oba grafy, vytvorit hash, spojit seznamy do alistu, porovnat objekty pomoci weak-equal-p a pak porovnat deti nerekurzivnim testem - zda kazde dite odpovida podle alistu
* mnohonasobna dedicnost - napr. beta-memory-node je zaroven beta-node (parenta) i memory-node (items)
	* moznosti - definovat copy-node v memory-node jako :after, :before, nebo :around

===== immutable objekty / objekty s destruktivnimi metodami =====

==== immutable ====
* templates, facts, patterns, rules, tokens, tests (in beta join nodes)

==== mutable ====
* rete, environment - needs copy method

* base-object
	* implementuje copy-object, (setf object-slot)
		* pouzity jen v exil-parser:modify-fact

'''
(defclass environment ()
  ((facts :accessor facts :initform '(fact1 fact2 fact3))
   (templates :accessor templates :initform '((:a . tmpl1) (:b . tmpl2)))
   (rules :accessor rules :initform (make-hash-table))))

;; implementation of copy-env - lots of code with deep object composition structure

(defun add-fact (env fact)
  (let ((new-env (copy-env 'environment)))
    (setf (facts new-env) (cons fact (facts env)))
    new-env))

(defun add-template (env name template)
  (let ((new-env (copy-env 'environment)))
    (setf (templates new-env) (cons (cons name . template) (templates env)))
    new-env))

(defun add-rules (env name rule)
  (let ((new-env (copy-env 'environment)))
    (setf (rules new-env) (gethash
'''
 

;; bud vytvorim shallow-copy na kazde urovni, kde chci zmenu:
;; - add-fact - vytvorim novou instanci, ale sloty jsou stejne instance
;;   jako u puvodni, facts zkopiruju deep-copy, pak muzu pouzit
;;   destruktivni fuknkci
;; nebo deep copy najednou, ale pak muzu pracovat destruktivne
;; pripadne zadna copy, v praxi pravdepodobne neni potreba, ale pak
;; nejsem schopen testovat

;; bud muzu s jednotlivymi polozkami (hlavne sloty objektu) pracovat
;; nedestruktivne (cons misto push, remove misto delete), pak nemusim
;; resit kopirovani objektu jako celku
;; hrozi ale problem s vykonem - vetsina akci ale neni tak efektivni
;; jako cons u seznamu - je treba celou strukturu kopirovat
;; - remove, (setf gethash), (setf assoc)

;; nebo kopirovat jen v pripade potreby, nemusi byt ale vzdy evidentni
;; ze v danem miste hrozi problem, pokud se kopirovat nebude - vetsi
;; chybovost

;; menit destruktivne composite hodnoty slotu?
;; - vs kopirovat strukturu
;; menit destruktivne sloty v objektu?
;; - vs kopirovat cely objekt - nejen neefektivni, ale take podstatne vice kodu
