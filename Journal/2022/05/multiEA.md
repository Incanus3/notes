=== significant EARepository usages ===

- EARepositoryImpl is created in a few places - not problematic
- EARepository is autowired at a lot of places - will have to be qualified or acquired some other way
- EAObjectBuilder and EAConnectorBuilder may hold EARepository instance
- EaManager holds EARepository instance
  - subclasses typically take it as constructor param
    - they are instantiated manually, typically in RegistryConfiguration, so this is the place where
      we pass the right instances to the right managers
  - EA slots use it to access other managers - presumably connected entities will all live in the
    same EA instance (??)
