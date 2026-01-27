- https://github.com/h2database/h2database/issues/4318
- problem nastava ve chvili, kdy se v ramci posledniho volani `registry.create()` v `AgendaTestDataLoader`u zavola `createRelation` callback pro `Agenda.capabilita`, coz je custom relation slot
- v `createRelation` se vola `create()` pro `KatalogAgend`, ktera v bloku vola `find()` na registru `Capabilit` pro gid "gid-cap-mpss-01"
- tenhle `find()` dojde az do `EaObjectManager.findInsideDomain()` a posleze do `DbQuery.findOne()` -> `QueryWrapper.findOne()` -> `DefaultOrmQuery.findOne()` -> ...
- query je zde 
```sql
select t0.OBJECT_ID, t0.EA_GUID, t0.ALIAS, t0.PDATA1, t0.PDATA5, t0.VISIBILITY,
	t0.NAME, t0.STEREOTYPE, t0.TPOS, t0.OBJECT_TYPE, t0.STATUS,
	t0.Version, t0.Phase, t0.PARENTID, t0.PACKAGE_ID, t0.CLASSIFIER,
	(case when t0.object_type = 'Package' then 1 else 2 end),
	t0.AUTHOR, t0.CREATEDDATE, t0.MODIFIEDDATE
from T_OBJECT t0
where t0.STEREOTYPE = ?
and t0.PACKAGE_ID in (
	select t0.PACKAGE_ID from T_PACKAGE t0 where t0.EA_GUID in (
		select t0.EA_GUID from T_OBJECT t0 where t0.STEREOTYPE = ? and t0.PACKAGE_ID in (
			select t0.PACKAGE_ID from T_PACKAGE t0 where (
				t0.PACKAGE_ID in (
					select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PACKAGE_ID in (?)
				) or t0.PACKAGE_ID in (
					select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (
						select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PACKAGE_ID in (?)
					)
				) or t0.PACKAGE_ID in (
					select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (
						select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (
							select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PACKAGE_ID in (?)
						)
					)
				) or t0.PACKAGE_ID in (
					select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (
						select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (
							select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (
								select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PACKAGE_ID in (?)
							)
						)
					)
				) or t0.PACKAGE_ID in (
					select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (
						select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (
							select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (
								select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (
									select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PACKAGE_ID in (?)
								)
							)
						)
					)
				)
			)
		)
	)
) and t0.EA_GUID = ?
```
