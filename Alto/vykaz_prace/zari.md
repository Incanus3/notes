Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-11-02T11:58:06+01:00

====== zari ======
Created Saturday 02 November 2013

3.9.		reseni schema databazi, vytvareni zakladni struktury projektu = 1h30
5.9.		reseni schemat databazi = 1h
10.9.	reseni schemat databazi (constrainty) = 2h
12.9.	vytvoreni modelu nad tabulkami, nastaveni asociaci, znasilneni active recordu kvuli nestandardnimu nazvoslovi = 4h
14.9.	vytvoreni modelu objednavek (osekani atributu spolecnych s jidelakem, reseni constraintu),
		zakladni reseni objednavek - vyber jidla podle jidelny, data, chodu a cisla = 3h
15.9.	vyber jidelny pro objednavky, vytvoreni zakladniho seznamu pro obednavky (na den), navyseni poctu porci pri objednani = 4h

19.9 - 3h
* pridano datum do hlavicky show_day - Date.today.to_formatted_s(:long)
* refaktor order_meal - rozumne vytvoreni nove objednavky, nebo aktualizace stavajici
* refaktor show_day - vytvoreni novych/vyhledani stavajicich objednavek uz v controlleru, extrakce course_menu parialu, zobrazeni snidani, obedu a veceri, oprava vyberu jidelny
* pridani vyberu data, ceska lokalizace

20.9 - ostylovani = 4h

21.9 - 2h30
* stylovani, extrakce date_selection
* vytvareni sablony pro vyber jidla s radio buttony

22.9 - 4h
* reseni problemu s ActiveModel dirty flagy
* formular pro single portion policy

24.9 - 7h
* cleaning up orders controller
* first working version with options select for single meal for course policy
* canceling of order, unselecting options when order is canceled (workaround)
* putting order cancel in options form - multibutton form
* stylovani

25.9 - 7h
* pridani +/- buttonu do show_day_table
* stylovani - mensi buttony v tabulkach, headery, formulare
* refaktoring application helperu
* seedy
===============
43h
