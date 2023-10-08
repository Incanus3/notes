Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-08-18T23:14:02+02:00

====== centralpoint ======
Created Sunday 18 August 2013

* vyresit, zda je treba prevadet ciselne hodnoty, obdrzene jako string z params, pri vkladani do db

=== zamky ===
(03:08:57 PM) evzen kalab: s tema zamkama je to takhle: kdyz zakaznici konzumujou v hospode nacitaj se jim body a za ne si muzou vybrat naky odmeny ...
(03:09:30 PM) evzen kalab: ovsem pred vyberem je poteba zjistit, jestli na danou odmenu ma dost bodu a zaroven to zajistit jako transakci ...
(03:10:31 PM) evzen kalab: takze ten get1 sdeli kolik ma bodu, zaroven to zamkne, aby ten clovek nemohl ty body spotrebovat (=odecist) 2* najednou
(03:11:10 PM) evzen kalab: a ten zamek se testuje jen u odcitacich transakci, pridavat dalsi body jde bez omezeni
(03:11:16 PM) Incanus: aha, takze na zacatku je dotaz na get1, pak je to samotny odecteni a pak naky odemceni, kazdy v extra requestu?
(03:11:57 PM) evzen kalab: get1 zamkne, odecteni zaroven odemkne

* moznost zmeny obednavky, nastavitelnost do kolika (kolik hodin predem), kolik tydnu dopredu uvidi
* moznost videt historii objednanych + sezranych jidel, nastavitelnost (co se stane, kdyz nesezere, apod.) na urovni jednotlivych stravniku

* typy karet - firemni, 
	* individualovy - kredit zakaznika, neomezeny pocet objednavek, porci
	* firemni
		* a) jen jedno jidlo z kazdeho chodu
		* b) bez limitu
	* na urovni stravnika vyber individual/firemni
	* na urovni provozovatele vyber - jak se chova k firemnim uctum
* tyden je pevny, ne klouzavy
