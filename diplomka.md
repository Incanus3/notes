Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2011-11-07T14:06:24+01:00

====== Diplomka ======
Created Monday 07 November 2011

* v uvodu popsat CLISP, dopredne a zpetne retezeni, SLD rezoluci prologu
* dokumentace - If you were looking to generate a full manual on a piece of software for internal use then you are looking at programs such as clod, declt, sb-texinfo or tinaa. 

* popisky undo-stacku by mely odpovidat presnemu volani funkci
	* formatovat lepe undo-label u defrule
* zkontrolovat navratove hodnoty vsech front-end funkci
* mel by select-activation odstranit match z activations?
* exil:facts by mel vracet seznam, ne tisknout, uzivatel se pak muze rozhodovat, co s nim udela (filtrace, vypis ve vlastnim formatu, ...)
	* urcite nelze vracet seznam skutecnych objektu - to je interni reprezentace, muze se zmenit
	* moznosti
		* vracet seznam stringu - jednoduche
		* vracet seznam S-vyrazu, reprezentujicich fakt - kdyz bude odpovidat reprezentaci, kterou parser zna, byla by mozna dalsi manipulace (assert, retract, modify)
			* assert, retract berou specifier bez quotovani (pohodlne, clips-compatible), tudiz ale nelze zpatky predat specifier ulozeny v promenne (assert by jmeno promenne quotoval a bral ho jako specifier)
				=> pridat (nebo zverejnit) assert%, retract%, modify%, ktere nequotuji
* fakta a patterny by se mely tisknout ve stejne reprezentaci, v jake byly zadany - treba ukladat reprezentaci pri parsingu a vetvit podle ni print-object (nebo format-object)
* jestli je lisp kod self-explainable, pak kod s testy, ktere presne a expresivne popisuji chovani api posouva tuto vlastnost jeste dal
* ExiL umoznuje jakykoli kod v RHS pravidla, tudiz napr. i watch, set-strategy, apod., je tedy potreba i tyto funkce, ktere jsou jinak volany jen primo front-endem, ne mezi sebou, take obalit tak, aby nemenily undo-stack, kdyz jsou volany z RHS pravidla

* zvazit undo/redo na konkretni pozici - nemuselo by byt tak slozite
* pokud bude cas, pridat undo/redo stacky do gui
