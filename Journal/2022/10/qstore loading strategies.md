== QStoreTableLoaderBase ==

- lines 78 a 92 vezmou vsechny resourcy v repozitari a ulozi je v mapu podle id, to by nikdy nemelo
  byt null - pouzil bych nejspis !!
- lines 215 a 220 odstrani z mapu resource pro sourceEntity.gid, pokud targetResource existuje (bud
  se updatene, nebo ne, to se co do odstranovani z mapu nerozlisuje)
- lines 89 a 103 smaze vsechny resourcy, ktere v mapu zustaly, coz jsou ty, pro ktere uz neexistuje
  sourceEntity
