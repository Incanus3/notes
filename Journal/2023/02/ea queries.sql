== puvodni implementace inSubtreeOfIds pred refactorem, kdy vola inSubtreeOf(query) ==
override fun inSubtreeOfIds(rootPackageIds: Collection<Long>, maxDepth: Int): EaPackageQuery {
    var currentQuery = QEaPackage(database).where().parentId.isIn(rootPackageIds)
    val partialQueries = buildList {
        repeat(maxDepth) {
            add(currentQuery)
            currentQuery = QEaPackage(database).where().parentId.isIn(currentQuery.idQuery())
        }
    }

    val finalQuery = partialQueries.fold(
        QEaPackage().where().or().id.isIn(rootPackageIds),
    ) { compound, partial ->
        compound.id.isIn(partial.idQuery())
    }.endOr()


== KomponentaInformacnihoAktivaManager.query ==

-- vyhledani root package ids podle guidu
select t0.PACKAGE_ID from T_PACKAGE t0 where t0.EA_GUID in (?);
--bind(Array[1]={{7D11D8CE-D464-477b-85DE-DA25DD8C6CF4}})
--micros(52)

-- vyhledani domenovych packagu (resp. jejich self objectu)
select t0.EA_GUID from T_OBJECT t0 where t0.STEREOTYPE = ? and t0.PACKAGE_ID in (
  select t0.PACKAGE_ID from T_PACKAGE t0 where (
    t0.PACKAGE_ID in (?)
    or t0.PACKAGE_ID in (
      select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (?)
    ) or t0.PACKAGE_ID in (
      select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (
        select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (?)
      )
    ) or t0.PACKAGE_ID in (
      select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (
        select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (
          select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (?)
        )
      )
    ) or t0.PACKAGE_ID in (
      select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (
        select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (
          select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (
            select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (?)
          )
        )
      )
    ) or t0.PACKAGE_ID in (
      select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (
        select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (
          select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (
            select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (
              select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (?)
            )
          )
        )
      )
    )
  )
);
--bind(Skupina činností,Array[1]={12},Array[1]={12},Array[1]={12},Array[1]={12},Array[1]={12},Array[1]={12})
--micros(88)

-- vyhledani komponent IA pres parenty (IA, katalog, capabilita) v ramci vyse nalezenych guidu dome
select t0.OBJECT_ID, t0.NAME, t0.ALIAS, t0.STEREOTYPE, t0.NOTE, t0.TPOS, t0.EA_GUID, t0.OBJECT_TYPE, t0.AUTHOR, t0.PARENTID, t0.PACKAGE_ID, t0.BACKCOLOR, t0.PDATA1, t0.CLASSIFIER, t0.STATUS, t0.Version, t0.CREATEDDATE, t0.MODIFIEDDATE
from T_OBJECT t0 where t0.PARENTID in (
  select t0.OBJECT_ID from T_OBJECT t0 where t0.PARENTID in (
    select t0.OBJECT_ID from T_OBJECT t0 where t0.PARENTID in (
      select t0.OBJECT_ID from T_OBJECT t0 where t0.PACKAGE_ID in (
        select t0.PACKAGE_ID from T_PACKAGE t0 where t0.EA_GUID in (?,?,?,?,?,?)
      ) and t0.STEREOTYPE = ?
    ) and t0.STEREOTYPE = ?
  ) and t0.STEREOTYPE = ?
) and t0.STEREOTYPE = ?;
--bind(Array[6]={{gid-cdo-1000},{gid-cdo-1100},{gid-cdo-1110},...},Process Subdomain,Katalog IA,Informační aktivum Instance,Komponenta informačního aktiva Instance)
--micros(875)



= pri vetsich datech =
select t0.PACKAGE_ID from T_PACKAGE t0 where t0.EA_GUID in (?);
--bind(Array[1]={{7D11D8CE-D464-477b-85DE-DA25DD8C6CF4}})
--micros(33)

select t0.EA_GUID from T_OBJECT t0 where t0.STEREOTYPE = ? and t0.PACKAGE_ID in (select t0.PACKAGE_ID from T_PACKAGE t0 where (t0.PACKAGE_ID in (?) or t0.PACKAGE_ID in (select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (?)) or t0.PACKAGE_ID in (select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (?))) or t0.PACKAGE_ID in (select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (?)))) or t0.PACKAGE_ID in (select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (?))))) or t0.PACKAGE_ID in (select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (select t0.PACKAGE_ID from T_PACKAGE t0 where t0.PARENT_ID in (?))))))));
--bind(Skupina činností,Array[1]={12},Array[1]={12},Array[1]={12},Array[1]={12},Array[1]={12},Array[1]={12})
--micros(1751)

select t0.OBJECT_ID, t0.NAME, t0.ALIAS, t0.STEREOTYPE, t0.NOTE, t0.TPOS, t0.EA_GUID, t0.OBJECT_TYPE, t0.AUTHOR, t0.PARENTID, t0.PACKAGE_ID, t0.BACKCOLOR, t0.PDATA1, t0.CLASSIFIER, t0.STATUS, t0.Version, t0.CREATEDDATE, t0.MODIFIEDDATE from T_OBJECT t0 where t0.PARENTID in (select t0.OBJECT_ID from T_OBJECT t0 where t0.PARENTID in (select t0.OBJECT_ID from T_OBJECT t0 where t0.PARENTID in (select t0.OBJECT_ID from T_OBJECT t0 where t0.PACKAGE_ID in (select t0.PACKAGE_ID from T_PACKAGE t0 where t0.EA_GUID in (?,?,?,?,?,?)) and t0.STEREOTYPE = ?) and t0.STEREOTYPE = ?) and t0.STEREOTYPE = ?) and t0.STEREOTYPE = ?;
--bind(Array[6]={{gid-cdo-1000},{gid-cdo-1100},{gid-cdo-1110},...},Process Subdomain,Katalog IA,Informační aktivum Instance,Komponenta informačního aktiva Instance)
--micros(14627)


== KomponentaInformacnihoAktiva.getDomain ==

select t0.PACKAGE_ID, t0.NAME, t0.EA_GUID, t0.PARENT_ID, t0.TPOS from T_PACKAGE t0 where t0.EA_GUID in (?);
--bind(Array[1]={{7D11D8CE-D464-477b-85DE-DA25DD8C6CF4}})
--micros(67)

select t0.PACKAGE_ID, t0.NAME, t0.EA_GUID, t0.PARENT_ID, t0.TPOS from T_PACKAGE t0 where t0.PARENT_ID in (?);
--bind(Array[1]={12})
--micros(204)

select t0.PACKAGE_ID, t0.NAME, t0.EA_GUID, t0.PARENT_ID, t0.TPOS from T_PACKAGE t0 where t0.PARENT_ID in (?,?);
--bind(Array[2]={32,36})
--micros(141)

select t0.PACKAGE_ID, t0.NAME, t0.EA_GUID, t0.PARENT_ID, t0.TPOS from T_PACKAGE t0 where t0.PARENT_ID in (?,?);
--bind(Array[2]={33,37})
--micros(35)

select t0.PACKAGE_ID, t0.NAME, t0.EA_GUID, t0.PARENT_ID, t0.TPOS from T_PACKAGE t0 where t0.PARENT_ID in (?);
--bind(Array[1]={34})
--micros(18)

select t0.PACKAGE_ID, t0.NAME, t0.EA_GUID, t0.PARENT_ID, t0.TPOS from T_PACKAGE t0 where t0.PARENT_ID in (?);
--bind(Array[1]={35})
--micros(15)

select t0.OBJECT_ID, t0.NAME, t0.ALIAS, t0.STEREOTYPE, t0.NOTE, t0.TPOS, t0.EA_GUID, t0.OBJECT_TYPE, t0.AUTHOR, t0.PARENTID, t0.PACKAGE_ID, t0.BACKCOLOR, t0.PDATA1, t0.CLASSIFIER, t0.STATUS, t0.Version, t0.CREATEDDATE, t0.MODIFIEDDATE
from T_OBJECT t0 where t0.EA_GUID in (?,?,?,?,?,?,?);
--bind(Array[7]={{7D11D8CE-D464-477b-85DE-DA25DD8C6CF4},{gid-cdo-1000},...})
--micros(240)

select t0.PACKAGE_ID, t0.NAME, t0.EA_GUID, t0.PARENT_ID, t0.TPOS
from T_PACKAGE t0 where t0.EA_GUID in (?,?,?,?,?,?);
--bind(Array[6]={{gid-cdo-1000},{gid-cdo-1100},{gid-cdo-1110},...})
--micros(58)

select t0.OBJECT_ID, t0.NAME, t0.ALIAS, t0.STEREOTYPE, t0.NOTE, t0.TPOS, t0.EA_GUID, t0.OBJECT_TYPE, t0.AUTHOR, t0.PARENTID, t0.PACKAGE_ID, t0.BACKCOLOR, t0.PDATA1, t0.CLASSIFIER, t0.STATUS, t0.Version, t0.CREATEDDATE, t0.MODIFIEDDATE
from T_OBJECT t0 where t0.PACKAGE_ID in (?,?,?,?,?,?) and t0.STEREOTYPE in (?) order by t0.NAME;
--bind(Array[6]={32,33,34,35,36,37},Array[1]={Katalog IA})
--micros(420)

select t0.OBJECT_ID, t0.NAME, t0.ALIAS, t0.STEREOTYPE, t0.NOTE, t0.TPOS, t0.EA_GUID, t0.OBJECT_TYPE, t0.AUTHOR, t0.PARENTID, t0.PACKAGE_ID, t0.BACKCOLOR, t0.PDATA1, t0.CLASSIFIER, t0.STATUS, t0.Version, t0.CREATEDDATE, t0.MODIFIEDDATE
from T_OBJECT t0 where 1=0 and t0.PARENTID = ? order by t0.TPOS, t0.NAME;
--bind(0)
--micros(309)

select t0.OBJECT_ID, t0.NAME, t0.ALIAS, t0.STEREOTYPE, t0.NOTE, t0.TPOS, t0.EA_GUID, t0.OBJECT_TYPE, t0.AUTHOR, t0.PARENTID, t0.PACKAGE_ID, t0.BACKCOLOR, t0.PDATA1, t0.CLASSIFIER, t0.STATUS, t0.Version, t0.CREATEDDATE, t0.MODIFIEDDATE
from T_OBJECT t0 where t0.PARENTID in (?,?,?,?) order by t0.TPOS, t0.NAME;
--bind(Array[4]={73,74,75,72})
--micros(333)

select t0.OBJECT_ID, t0.NAME, t0.ALIAS, t0.STEREOTYPE, t0.NOTE, t0.TPOS, t0.EA_GUID, t0.OBJECT_TYPE, t0.AUTHOR, t0.PARENTID, t0.PACKAGE_ID, t0.BACKCOLOR, t0.PDATA1, t0.CLASSIFIER, t0.STATUS, t0.Version, t0.CREATEDDATE, t0.MODIFIEDDATE
from T_OBJECT t0 where 1=0 and t0.PARENTID = ? order by t0.TPOS, t0.NAME;
--bind(0)
--micros(25)

select t0.OBJECT_ID, t0.NAME, t0.ALIAS, t0.STEREOTYPE, t0.NOTE, t0.TPOS, t0.EA_GUID, t0.OBJECT_TYPE, t0.AUTHOR, t0.PARENTID, t0.PACKAGE_ID, t0.BACKCOLOR, t0.PDATA1, t0.CLASSIFIER, t0.STATUS, t0.Version, t0.CREATEDDATE, t0.MODIFIEDDATE
from T_OBJECT t0 where t0.PARENTID in (?,?,?,?,?,?,?,?,?,?,?,?,?) order by t0.TPOS, t0.NAME;
--bind(Array[13]={80,81,82,83,84,85,86,87,88,76,77,78,79})
--micros(378)
