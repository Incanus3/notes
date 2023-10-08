[ ] opravit ovocenkovy registracni formular - newslettery - problem s locales

[ ] aktualizovat redmine - 3.0.0 -> 3.2.0

[ ] prepsat AttributeShortcutting pomoci AR attribute
http://edgeapi.rubyonrails.org/classes/ActiveRecord/Attributes/ClassMethods.html

[ ] makro - copie se neposila na makroakademii

[ ] opravit rezervace po uprave result_objects

[ ] bakare - registrace
- newslettery
  - musi byt upravitelne pro jednotlive instance - neni velky problem renderovat partial dynamicky,
    ale formular musi s poli taky pocitat - bud mit subclassy podle retezce, nebo udelat nejak obecne
  - newsletter by vlastne mohl byt attribut CreateClientFormu typu Hash a jenom by se redaval dal
    - ve view je ale nejspis v ramci client fields
    - navic form musi mit readery pro konkretni inputy - coz lze udelat dynamicky, ale hrozi
      konflikt
    - teoreticky ale muze mit atribut CCF#newsletters, ktery se bude coercovat na OpenStruct
  - proc vlastne neni registration_context, ktery obsahuje akorat spoustu kondicionalu, implementovan
    take subclassami pro retezce?
- presmerovani po aktivaci/password resetu/unlocku
  - je implementovano, ale konfigurace neni nastavena ani pro AZ

[ ] upravit rezervace tak, aby se tam dalo zadat slovenske cislo - udajne normalizuje na ceske (nebo
    nepovoli?)

[ ] objednavky - pridat validace CreateClientForm#card_number
[ ] objednavky - upravit registraci tak, aby
- v pripade nejasnosti nabizela overeni pomoci cisla a data vystaveni dokladu
- jedine, kdy nebude vyzadovat, bude nejspis ve chvili, kdy zadany email odpovida klientske databazi

[ ] bakare
- Celou sekci Fakturační adresa, která je nyní jako povinný údaj, udělat na nepovinný.
- Sekce Newslettery - ideálně smazat, nebo do ní přidat možnost zaškrtnou výber newsletteru. Ideálně:
- Newsletter - týdenní menu
             - zasílání novinek Pizza Coloseum
- Nadpis v iFrame Registrace viz horní levý roh i Framu máte názvosloví - bakare - ten je potřeba odstranit.

[ ] projit kody slovaku

- pokud ma admin vybraneho makro klienta, funguje uprava profilu nad nim, je to v poradku?
