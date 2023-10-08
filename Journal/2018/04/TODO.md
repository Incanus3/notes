==== TODO ====

=== hajek ===

[ ] nasadit na production vsechny aktualizace
[ ] sepsat standovi, co tam kde je

=== bakare ===

[ ] odstranit auth overridy - lze resit jednoduseji overridem client_finderu
[ ] odstranit vouchery z projektu - namountovat z alto-django-actions
[ ] doresit situaci, kdy klient zavre po uspesne platbe driv, nez se redirect dostane na backend

=== benesov ===

[ ] vytvorit ds pro benesov s appkama pro - kredit, food, hotelovy pobyt (posledni chod jidla)
[ ] dat lence sql pristup do parlamentu a posleze do noveho ds
[ ] poslat lence dotazy pro vytvoreni usera (aktivovanyho s heslem jako cislo karty) a pobytu
[ ] domluvit s evzou jak vyresit doobjednavani
[ ] domluvit s pepinem odber

=== ostatni ===

[ ] rotovat eet logy na productionu
[ ] updatovat redmine




- kalkulace - rozhoduje o dph, apod.
- ve foodu se vytvori kalkulace a umisti se na kasu
- z toho kasa vygeneruje cenik
- pokud food provede zmeny, ktere se tykaji kasy, zapise do s_zmeny do radku s tab=foodie novy
  timestamp a kasa si zaktualizuje cenik
- food definuje nekolik views, ze kterych si kasa snaze vytvori cenik

- prodej alkoholu
  - operace je VK, c_stredisk a c_partner bude 0

- uzaverka
  - pise se do sk__*, c_uzaverka je c_stredisk kasy

- hores
  - /dotaz/ho/account_for_guest - seznam hostu na pokoji
  - /reception - zapis utraty do horesu
  - /groups - seznam ubytovanych skupin
  - /guests - seznam pokoju
  - kasa vybere typ platby hotelovy ucet
    -> nabidne se seznam pokoju nebo skupin, cisnik vybere
  - v hores_d je seznam pristupu k horesu
    - pokud je zaznam jeden, rovnou se dotazes
    - pokud je jich vic, vrati se seznam hodnot v hor_hotel, kasa vybere konkretni instanci horesu

  - testovaci instance ext.alto.sk:7443 - https, pristup nejspis hores:hores

- priority
  - otestovat zapis skcek
    - funkce to_sk (\df+ to_sk)
  - hores
