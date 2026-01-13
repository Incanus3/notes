- po - 10-17 kancl, oprava CORS, pridani mailovych notifikaci do KB
- ut - nic, ale vykazat nedeli - studium oauthu, cca 8h
- st - 9.30-18.30 kancl, maily v KB, stazeni exportu
- ct - 10-17 pridani optionu pro detail column, json export
- pa - kancl - 9-16.15 - finalizace json exportu, report runner - pouzit nove endpointy

== kompozice queries a searche, idealne i dalsich veci - paginace, sorty, etc. ==

- aktualne mame dva typy queries:
  - nizkourovnova qwazar.utils.Query, kterou implementuji
    - EaObjectQuery, EaConnectionQuery a EaPackageQuery (in-memory a db varianty)
    - tyto vraci nizkourovnove EA objekty, manazer je typicky vyhodnoti na list a pak je mapne na artefakty
    - jsou composable - ale zpusobem, ze se na ne daji chainovat dalsi metody, nejde nejspis jednoduse vzit dve tyto queries a "mergnout" je
  - vysokourovnove domain.query.EntityQuery
    - vraci entity
    - samy o sobe nic nedelaji - umoznuji pouze sestavit query, tedy kombinaci (slot, matcher, hodnota) tripletu
    - jsou tedy v podstate jen "definici" query (+ pohodlna metoda na vyhodnoceni, ktera ale jen deleguje)
    - vyhodnocuji se pomoci evaluatoru, ktere projdou "definici" a vyhodnoti na seznam
    - jsou composable tak, ze na ne lze jak chainovat, tak vzit dve a spojit je ANDem ci ORem
  - EaObjectEntityQueryEvaluator funguje tak, ze vyjde z manager.query (coz je nizkourovnova Query) a podle "definice" zadane (vysokourovnove) query na ni nabaluje, nakonec ji vyhodnoti a mapne na artefakty
  - pro kombinovatelnost searche s queries je tohle sikovne, protoze pokud se upravi search strategies tak, aby braly a vracely (nizkourovnove) queries, tak lze proste nejdriv prohnat manager.query skrze search strategy (pripadne i nekolik) a pote predat evaluatoru
  - soucasne pokud by EntityQuery ci evaluator umel krome listu vracet nizkourovnovu Query (coz by v pripade EA nemelo byt slozite), bude mozno chainovat i v opacnem poradi
  - problem je, jak tohle zobecnit, protoze non-EA evaluatory s (nizkourovnovymi) queries nepracuji
  - searche by navic nemely byt jen pred ci za, mely by byt na urovni jinych filteru, tedy melo by je byt mozne kombinovat do stromu spolu s dalsimi filtery
- pro nase potreby tedy potrebujeme strukturu ("high-level query", "entity query", apod.), ktera
  - poskytuje fluent api pro postupne buildovani query, tyto metody vraci dalsi instance HL query
  - lze ji snadno kopirovat, nechceme tedy hierarchii trid, logika specificka pro ruzne registry, resp. manazery, by mela byt externi (aktualne reseno pomoci evaluatoru)
  - je schopna drzet vsechny informace pozadavcich klienta
  - ma vsechny veci potrebne pro jeji vyhodnoceni, k tomu by mel snad byt dostacujici evaluator
  - v plne implementaci je schopna drzet filtry (coz je nejspis i search) v nested strukture s AND/OR na kazde urovni
  - (predchozi pozadavky nevypadaji jako prilis problematicke, ale dale)
  - je potreba, aby mohla vyjit uz z nejak omezenych dat, ale nezavisle na konkretni implementaci manazeru, resp. evaluatoru
	- tohle je potreba primarne pro EaManagery, ty nepracuji nad oddelenymi "repozitari", jako je tomu u db artefaktu (kazda entita ma vlastni tabulku), ci in-memory manazeru (kazdy manager uklada oddelenou mapu entit), vsechna data lezi na jedne hromade (EA) vsechny queries daneho registru/manazeru musi byt nejprve predfiltrovany pomoci Manager.query
	- problem ale je, ze obecna EntityQuery o EA queries nic nevi - ostatni manazery aktualne s (nizkourovnovymi) Queries nepracuji, i kdyz by potencialne mohly
	- naskytuji se tedy (minimalne) 3 reseni
		- (a) pridat do EntityQuery atribut pro "initial low-level query" a upravit vsechny manazery tak, aby pracovaly s Queries
			+ unifikace implementaci, ktera ve skutecnosti nemusi byt uplne spatny napad
			- ne pro vsechny manazery musi byt Queries vyhovujici (i kdyz obecny Query interface ve skutecnosti vubec zadne pozadavky na implementaci neklade, specifikuje pouze sadu "terminalnich" metod)
	        - muze byt dost prace
		- (b) pridat do EntityQuery atribut pro "init LL query", ale udelat ho optional a ostatni
        manazery vyuzivat nebudou
			+ prakticke a typovane
			- pusobi trochu divne, ze mame atribut, ktery je (alespon aktualne) specificky pro jeden konkretni typ manazeru
		- (c) pridat nejaky naprosto obecny atribut pro "additial evaluation data", kde si manazer pri vytvoreni EntityQuery muze ulozit "cokoli" a to pak evaluator obdrzi s "pozadavkem o vyhodnoceni"
			+ velmi flexibilni
			- osklive netypovane - evaluator si bude muset to "cokoli" castnout a doufat, ze dostane to, co cekal
	- aktualne bych se priklanel k reseni (b) protoze
		- splnuje pozadavky
		- je rozumne typovane
		- nevyzaduje zadne zmeny v manazerech
		- v budoucnu, kdybychom se rozhodli prepsat vsechny managery na Queries, neni zadny problem udelat atribut povinny, a bude polozen rozumny zaklad
    - proc vlastne potrebujeme LL query ukladat separatne v HL query? vzdyt EaObjectEntityQueryEvaluator uz si ji ted uklada, resp. uklada manazer a pres ten se k ni dostane
    - ukladat ji by bylo potreba jedine v pripade, ze bychom ji chteli uz v prubehu nejak menit, to by ale podle me nemelo byt potreba, pokud bude HL query schopna ulozit vsechny potrebne pozadavky vcetne searchu
    - mozna to tedy (alespon ted) nutne neni, vysledna HL query by tedy mohla vypadat nejak takto
      - page 5, page size 100
      - order by name (ordering ale budeme resit pozdeji)
      - filters:
        (search "developer" AND age < 40) OR (search "manager" AND age > 40)
    - tato reprezentace ovsem vyzaduje upravu aktualniho modelu EntityQuery, ktery ted funguje tak, ze kazda EQ (HL query) uklada:
		- operator (AND/OR)
		- evaluator
		- v budoucnu potencialne paging a ordering
		- seznam EntityQueryConditions, kde kazda uklada
	        - property
	        - matcher
	        - value
	- tento model ma dva nedostatky:
		- neumoznuje nesting
		- umoznuje jen "klasicke" (slot-based) filtery (property-matcher-value triplety)
    - aby model umoznoval vsechno, co potrebujeme, je potreba nasledujicich zmen:
      - top-level query musi ukladat jen veci, speicifcke pro celou query, tedy evaluator, paging a ordering, pripadne inicialni query, pokud bude potreba (viz vyse)
      - pro filtery (coz je i search) je potreba, abychom byli schopni ukladat stromovou strukturu,
        kde kazdy uzel stromu bude mit
        - operator (AND/OR)
        - seznam filtru, coz ale musi byt obecnejsi vec, nez aktualni EntityQueryCondition, protoze musi byt schopna reprezentovat jak "klasicky" slot-filter triplet, tak search, tak potencialne i jine typy filteru
        - musime tedy nejspis zavest nejaky obecny interface pro EntityFilter a ruzne jeho implementace
        - to bude klast vetsi naroky na evaluator, protoze ten bude muset byt schopen evaluovat ruzne typy filteru, ale to je asi inherentni slozitost
        - u manazeru, ktere pracuji s Queries si dokazu predstavit dvoufazove spracovani
			- jeden kus logiky bude prevadet specificke typy EntityFilter na jeden unifikovany typ, ktery bude vzdy aplikovat nejakou transformaci na LL query
          - druhy kus logiky bude tyto unifikovane query-based EntityFiltery composovat dohromady
          - kdyby vsechny manazery pracovaly s Queries, bylo by to sikovne v tom, ze tato druha cast
            by mohla byt implementovana primo v EntityQuery, nikoli resena konkretnimi evaluatory,
            protoze tahle logika by byla nezavisla na konkretnim manazeru, potazmo evaluatoru
    - po zakladnim navrhu mame tento model:
      - obecny EntityFilter interface, implementacemi bude
        - EntitySlotValueFilter
        - EntitySearchFilter
        - muze jich byt vic - nejsou predem zname
      - interface EntityFilterNode pro stavbu stromu filteru, zde bude predem znama mnozina typu:
        - SingleFilter - uklada proste jeden EntityFilter
        - CompoundFilter - uklada operator (AND/OR) a seznam operandu, tedy nested EntityFilterNodu
      - EntityQuery - uklada evaluator, v budoucnu paginaci a ordering, a rootovy EntityFilterNode
    - tohle vypada jako navrh, ktery by mohl pokryvat vsechny nase potreby, ale nastava tu otazka:
    - jak bude u takhle obecneho modelu vypadat buildovani queries?
      - idealni by bylo fluent api, ale jsou tu dva problemy
        1) zakladni model nevi, jake filtery budou existovat, to by ale samo o sobe takovy problem
          byt nemusel - pokud bude query poskytovat API pro pridani filteru, neni problem definovat
          extension metody, ktere budou buildovat ruzne filtery a pak je pomoci tohoto API pridaji
        2) pokud by melo byt fluent api linearni, jak bude vedet, kam do stromu novy filter zaradit?
          - lze resit metodami .and(), .endAnd(), .or(), .endOr() podobne, jako to ma ebean, builder
            by si pak pamatoval, na jakou pozici zrovna pridava, a dle potreby pri pridaval uzly
            nodu
          - na druhou stranu, pro linearnost ve skutecnosti asi duvod neni - metody muzou brat bloky
            pro buildovani nested filteru
            - to se muze jeste zjednodusit, pokud rekneme, ze top-levelova EntityQuery sama
              implementuje interface CompoundFilteru

A AND (b OR (c AND d) OR e OR (f AND g) OR h) AND i

- lze zapsat jako

employees.query().filter(a).anyOf { this: CompoundFilter(OR)
  filter(b).allOf { this: CompoundFilter(AND)
    filter(c).filter(d)
  }.filter(e).allOf { this: CompoundFilter(AND)
    filter(f).filter(g)
  }.filter(h)
}.filter(i)

- kde volani filter(a) muze byt nahrazeno extension metodou, napr. where { age < 30 }
- pokud bude samotna EntityQuery implementovat interface CompoundFilter (tedy metodu filter(), ktera
  pridava filter do seznamu), lze pro kazdy typ EntityFilteru napsat jednu extension metodu nad
  timto interfacem (ktera vytvori instanci EntityFilter a zavola s nim filter()) a ta pak bude
  fungovat jak na top-level urovni, tak v nested AND/OR blocich


- built manually with search first
select distinct t0.OBJECT_ID, t0.NAME, t0.ALIAS, t0.STEREOTYPE, t0.NOTE, t0.TPOS, t0.EA_GUID, t0.OBJECT_TYPE, t0.PARENTID, t0.PACKAGE_ID, t0.BACKCOLOR, t0.PDATA1, t0.CLASSIFIER, t0.STATUS, t0.Version,
  (case when t0.object_type = 'Package' then 1 else 2 end), t0.CREATEDDATE, t0.MODIFIEDDATE, t0.AUTHOR
from T_OBJECT t0 join T_OBJECTPROPERTIES u1 on u1.OBJECT_ID = t0.OBJECT_ID
where lower(t0.NAME) like ? escape'|' and u1.PROPERTY = ? and not (lower(u1.Value) like ? escape'|'); --bind(%a%,NAME_CZ,%a%) --micros(1,502)

- built manually with search last
select distinct t0.OBJECT_ID, t0.NAME, t0.ALIAS, t0.STEREOTYPE, t0.NOTE, t0.TPOS, t0.EA_GUID, t0.OBJECT_TYPE, t0.PARENTID, t0.PACKAGE_ID, t0.BACKCOLOR, t0.PDATA1, t0.CLASSIFIER, t0.STATUS, t0.Version,
  (case when t0.object_type = 'Package' then 1 else 2 end), t0.CREATEDDATE, t0.MODIFIEDDATE, t0.AUTHOR
from T_OBJECT t0 join T_OBJECTPROPERTIES u1 on u1.OBJECT_ID = t0.OBJECT_ID
where u1.PROPERTY = ? and not (lower(u1.Value) like ? escape'|' and lower(t0.NAME) like ? escape'|'); --bind(NAME_CZ,%a%,%a%) --micros(2,723)

- built by Registry.query()
select distinct t0.OBJECT_ID, t0.NAME, t0.ALIAS, t0.STEREOTYPE, t0.NOTE, t0.TPOS, t0.EA_GUID, t0.OBJECT_TYPE,
  t0.PARENTID, t0.PACKAGE_ID, t0.BACKCOLOR, t0.PDATA1, t0.CLASSIFIER, t0.STATUS, t0.Version,
  (case when t0.object_type = 'Package' then 1 else 2 end), t0.CREATEDDATE, t0.MODIFIEDDATE, t0.AUTHOR
from T_OBJECT t0 join T_OBJECTPROPERTIES u1 on u1.OBJECT_ID = t0.OBJECT_ID
where t0.STEREOTYPE = "PRODUCT"
and t0.PACKAGE_ID in (select t0.PACKAGE_ID from T_PACKAGE t0 where t0.EA_GUID in ("product_parent"))
and u1.PROPERTY = "NAME_CZ"
and not (lower(u1.Value) like "%a%" escape'|'
and lower(t0.NAME) like "%a%" escape'|')
order by t0.NAME;
--bind(PRODUCT,Array[1]={{product_parent}},NAME_CZ,%a%,%a%) --micros(3,374)




select distinct t0.OBJECT_ID, t0.NAME, t0.ALIAS, t0.STEREOTYPE, t0.NOTE, t0.TPOS, t0.EA_GUID, t0.OBJECT_TYPE, t0.PARENTID, t0.PACKAGE_ID, t0.BACKCOLOR, t0.PDATA1, t0.CLASSIFIER, t0.STATUS, t0.Version,
  (case when t0.object_type = 'Package' then 1 else 2 end), t0.CREATEDDATE, t0.MODIFIEDDATE, t0.AUTHOR
from T_OBJECT t0 join T_OBJECTPROPERTIES u1 on u1.OBJECT_ID = t0.OBJECT_ID
where t0.STEREOTYPE = ?
and t0.PACKAGE_ID in (select t0.PACKAGE_ID from T_PACKAGE t0 where t0.EA_GUID in (?))
and u1.PROPERTY = ?
and u1.Value = ?
and u1.PROPERTY = ?
and u1.Value = ?; --bind(PRODUCT,Array[1]={{product_parent}},NAME_CZ,apple,PRICE,3) --micros(6,360)

select from T_OBJECT
where id in (select from T_OBJECTPROPERTIES where property = "a" and value = "b")
and id in (select from T_OBJECTPROPERTIES where property = "b" and value = "c")



select t0.OBJECT_ID, t0.NAME, t0.ALIAS, t0.STEREOTYPE, t0.NOTE, t0.TPOS, t0.EA_GUID, t0.OBJECT_TYPE, t0.PARENTID, t0.PACKAGE_ID, t0.BACKCOLOR, t0.PDATA1, t0.CLASSIFIER, t0.STATUS, t0.Version,
  (case when t0.object_type = 'Package' then 1 else 2 end), t0.CREATEDDATE, t0.MODIFIEDDATE, t0.AUTHOR
from T_OBJECT t0
where t0.STEREOTYPE = ?
and t0.PACKAGE_ID in (select t0.PACKAGE_ID from T_PACKAGE t0 where t0.EA_GUID in (?))
and t0.OBJECT_ID in (select t0.OBJECT_ID from T_OBJECTPROPERTIES t0 where t0.PROPERTY = ? and t0.Value = ?)
and t0.OBJECT_ID in (select t0.OBJECT_ID from T_OBJECTPROPERTIES t0 where t0.PROPERTY = ? and t0.Value = ?)
; --bind(PRODUCT,Array[1]={{product_parent}},NAME_CZ,apple,PRICE,3) --micros(3,996)


select t0.OBJECT_ID, t0.NAME, t0.ALIAS, t0.STEREOTYPE, t0.NOTE, t0.TPOS, t0.EA_GUID, t0.OBJECT_TYPE, t0.PARENTID, t0.PACKAGE_ID, t0.BACKCOLOR, t0.PDATA1, t0.CLASSIFIER, t0.STATUS, t0.Version,
  (case when t0.object_type = 'Package' then 1 else 2 end), t0.CREATEDDATE, t0.MODIFIEDDATE, t0.AUTHOR
from T_OBJECT t0
where t0.PACKAGE_ID in (select t0.PACKAGE_ID from T_PACKAGE t0 where t0.EA_GUID in (?))
  and t0.STEREOTYPE in (?,?)
  and (
    t0.PARENTID = ?
    or t0.PACKAGE_ID in (
      select t0.PACKAGE_ID from T_PACKAGE t0 where t0.EA_GUID <> ?
    )
  )
; --bind(Array[1]={{source_parent}},Array[2]={SOURCE,SOURCE2},6,{source1}) --micros(5,546)
