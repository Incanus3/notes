=== developer experience ===

- ad automatizace code review - detekt
- ad bus factor - je potreba najit balanc tak, aby se vyplatilo udrzovat (pro pripad bus-hitu)
  znalost neceho, co denne nepouzivam
- ad code review juniory - super napad

- ad cistelnost vystupu CI:
  - tunu vystupu ma frontend
  - trochu se zlepsi s novym kotestem, to ale vyzaduje kotlin 1.6
- v ramci TD bych rad prosel testy a nektere zrychlil
- zavislosti bych rad doaktualizoval

=== in/out type constraints ===

- assigning value of type EaObjectManager<EaObjectEntity> to param of type
  EaManager<OwnerEntityType>, where OwnerEntityType : EaEntity
  - assigning more concrete manager of more concrete entity to variable of more generic ones
  - if we call output methods on the generic variable, it will be ok as the concrete values are
    subclasses of the generic manager type
  - if we call input methods on the generic variable, it will not be ok as the generic values aren't
    subclasses of the specific manager type

=== relation types ===

== one to many ==

- Entity to Entities - through connection, but we don't care - supported and tested
EntityOne.entityListSlot<EntityTwo>().fromConnectionSources() + EntityTwo.entitySlot<EntityOne>().fromConnectionTarget()
EntityOne.hasMany<EntityTwo>().asConnectionSources() + EntityTwo.belongsTo<EntityOne>().asConnectionTarget() (or source?!)
  - or in the other direction
  - the second naming is nicer in the relationship name, but the source/target specification on the
    belongsTo side is confusing - does it mean that I (EntityTwo) am the target or the connected entity (EntityOne) is?

- Entity to Connections - direct - not supported yet, planned for this sprint
Entity.connectionListSlot<Connection>().fromOutgoingConnections() + Connection.entitySlot<Entity>().fromMySource()
Entity.hasMany<Connection>().asOutgoingConnections() + Connection.belongsTo<Entity>().???()
  - the target may be an entity or a connection (not planned for now)
Entity.connectionListSlot<Connection>().fromIncomingConnections() + Connection.entitySlot<Entity>().fromMyTarget()
Entity.hasMany<Connection>().asIncomingConnections() + Connection.belongsTo<Entity>().???()
  - the source may be an entity or a connection (not planned for now)

- Entity to Connections - through another connection - not supported yet, not planned now
Entity.connectionListSlot<Connections>().asConnectionTargets() + Connection.entitySlot<Entity>.fromConnectionSource()
Entity.hasMany<Connections>().asConnectionTargets() + Connection.belongsTo<Entity>.asConnectionSource() (or target?!)
  - or in the other direction
- Connection to Entities - through another connection - not supported yet, not planned now
  - very similar
- Connection to Connections - through another connection - not supported yet, not planned now
  - very similar

== many to many ==

- Entities to Entities - through connections, but we don't care - supported and tested
EntityOne.entityListSlot<EntityTwo>().fromConnectionSources() + EntityTwo.entityListSlot<EntityOne>().fromConnectionTargets()
EntityOne.hasMany<EntityTwo>().asConnectionSources() + EntityTwo.hasMany<EntityOne>().asConnectionTargets()

- Entities to Connections - through other connections - not supported yet, not planned now
Entity.connectionListSlot<Connection>().fromConnectionSources() + Connection.entityListSlot<Entity>().asConnectionTargets()
Entity.hasMany<Connection>().asConnectionSources() + Connection.hasMany<Entity>().asConnectionTargets()
  - or in the other direction

- Connections to Connections - through other connections - not supported yet, not planned now
ConnectionOne.connectionListSlot<ConnectionTwo>().fromConnectionSources() + ConnectionTwo.connectionListSlot<ConnectionOne>().fromConnectionTargets()
ConnectionOne.hasMany<ConnectionTwo>().asConnectionSources() + ConnectionTwo.hasMany<ConnectionOne>().asConnectionTargets()

== one to one ==

- Entity to Entity - through connection - supported, but not tested
EntityOne.entitySlot<EntityTwo>().fromConnectionSource() + EntityTwo.entitySlot<EntityOne>().fromConnectionTarget()
EntityOne.hasOne<EntityTwo>().asConnectionSource() + EntityTwo.belongsTo<EntityOne>().asConnectionTarget() (or source?!)

- Connection to Entity - direct - supported and tested
Connection.entitySlot<Entity>().fromMySource() + Entity.connectionSlot<Connection>().fromOutgoingConnection()
Connection.hasOne<Entity>().fromMySource() + Entity.connectionSlot<Connection>().fromOutgoingConnection()
  - or in the other direction

- Entity to Connection - direct - not supported yet, planned for this sprint
Entity.connectionSlot<Connection>().fromOutgoingConnection() + Connection.entitySlot<Entity>.fromMySource()
Entity.hasOne<Connection>().asOutgoingConnection() + Connection.belongsTo<Entity>.???()
  - or in the other direction

- Entity to Connection - through another connection - not supported yet, not planned now
Entity.connectionSlot<Connection>().fromConnectionTarget() + Connection.entitySlot<Entity>.fromConnectionSource()
  - or in the other direction
- Connection to Entity - through another connection - not supported yet, not planned now
  - very similar
- Connection to Connection - through another connection - not supported yet, not planned now
  - very similar

- which side should use hasOne and which should use belongsTo?
  - this is easy in case of relational DBs using foreign keys - the side which has the fkey uses belongsTo
  - when using the entitySlot() API, we don't need to care, but if we'd like to support registries
    on top of relational DBs in the future, we may have to
