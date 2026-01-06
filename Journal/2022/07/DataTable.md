=== DataTable ===

- serializovat parametry v ramci serializace DT
  - nejspis udelat DataTableParams jako subclassu DataStructure
  - pridat transientEnumSlot - bude brat static enumeration nad enumem a .getItem() pak vrati
    samotny enum item
- pridat variantu DataTable.withParams(), ktera bude brat mapu a zdeserializuje na strukturu
  parametru (parametry bud musi byt DataStructure, nebo musi konkretni DataTable definovat
  deserializerParams lambdu)
- az frontend zacne posilat parametry v requestu na json api handler
  1) v JsonApiHandleru je deserializovat (z jsonu na map) a zavolat s nimi DataTable.withParams()
     pred tim, nez se zacnou vyhodnocovat comparingValueGettery filtru
  2) potencialne upravit FE a JsonApiHandler tak, aby se hidden a locked filtry (nejen hidden
     sloupce) braly a vyhodnocovaly jako mandatory
- frontend taky musi posilat selectedProfile v requestu na json api handler, ten pak podle nej
  vybere profil tabulky a pak muze posilat pouze sloupce, ktere nejsou hidden
- pridat endpoint, ktery podle nazvu tabulky a id profilu vrati serializaci DataTable
  - to se pouzije na to, aby se pri zmene profilu dala tabulka prekreslit, aniz by se muselo
    refreshovat cele view
- sloupce se ted ukladaji v mapu podle property, bylo by lepsi identifikovat namem, aby mohlo byt
  vice sloupcu nad jednou property (muze defaultovat na property.name)
- taky by bylo sikovnejsi ukladat poradi sloupcu separatne a nespolehat na poradi ulozeni v mapu
