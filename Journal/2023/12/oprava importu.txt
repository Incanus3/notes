- import aktualne pada na tom, ze pri zapisu gidu do relacnich slotu nenachazi entity v related registru
- mozna reseni:
  - odchytavat a ignorovat chyby pri setu - hrozi ale, ze se zamaskuji i jine chyby
  - nejakym zpusobem docilit toho, aby se hledalo i mimo domenu - nejspis nejakym thread-local flagem
    - hrozi, ze se vytvori spatne vazby tam, kde vazba pada mimo domenu ne proto, ze jeste nejsou
      vytvoreny nutne vazby ciloveho objektu, ktere ho do domeny zaradi, ale z nejakeho jineho duvodu
  - pridat machanismus, kterym by se deklarovalo, ze se vazba nastavi z druhe strany (od childa k
    parentu), a z teto strany se ma ignorovat - nejbezpecnejsi, ale take nejslozitejsi reseni

admin@test.cz
adminadmin


https://oauth.sentica.cz/oauth2/authorize?client_id=1ddf56f2-ff6f-4241-ad4e-be69dd44762f&redirect_uri=http://localhost:8090/auth/oauth-redirect&response_type=code
