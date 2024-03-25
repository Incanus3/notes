http://api.rubyonrails.org/classes/ActionView/Helpers/DateHelper.html - select date/time either from Time object or for specific model's (date/time) attribute

* duvody pro pouziti rails:
	* vsechno ma sve misto, spousty vysokourovnovych helperu -> podstatne agilnejsi vyvoj
		* session jako hash, cache jako hash
		* flash - uklada errory z predchoziho requestu, aby bylo mozno je zobrazit pri tom dalsim (prip. po redirectu) - notice u redirectu pouziva flash
		* rescue_from(error_class, :with => :method) - obali vsechny rest metody controlleru do rescue a pri zachyceni dane vyjimky zavola metodu
		* logger
		* confirm
	* skvele nastroje na testovani - rspec-rails, shoulda-matchers, capybara
	* spousta dokumentace
	* spousta pomocnych knihoven - napr. devise
