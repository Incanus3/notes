=== fix tests failing because of views ===

- after adding `create view` to seed.sql, all kb tests (expcept for the first run test class) are
  failing with "table t_object already exists"
- the table probably exists because ebean fails to drop it because there's a view that depends on it
- we don't have much control over the ebean drop-create proces (that I know of at the moment - would
  need to investigate further), so it may be easier to just drop all views in some "after class" hook
  - the db schema seems to be (re)populated for each class (not single test), because all tests off
    the first run class succeed
- but we don't want to add an @AfterClass teardown to each test, or create a base class just for this
  - there's already TransactionalTest base class, it doesn't belong there and we can't have
    multiple base classes
  - it also may not be that easy, because @AfterClass must be a static method, so it will be hard to
    access application context
    - well maybe not, see https://stackoverflow.com/questions/54934830/spring-boot-testing-teardown-for-a-bean
- when studying the test startup, I came upon the these classes that may be useful to achieve this:
  - org.springframework.test.context.junit.jupiter.SpringExtension
  - org.springframework.test.context.TestContextManager (called from
    SpringExtension.postProcessTestInstance)
  - org.springframework.test.context.support.DefaultTestContext (its getApplicationContext() is
    called (indirectly) from TestContextManager.prepareTestInstance())
  - org.springframework.boot.test.context.SpringBootContextLoader (its loadContext() is called
    (indirectly) from ^^)
- ebean startup is simpler to enter - it starts in (eaMaster)Database bean method, with the
  `DatabaseFactory.create()` call
- important methods:
  - DdlGenerator.execute() -> .runDdl() -> .runDdlWith(connection)
    - this calls createSchema, runInitSql, runDropSql, runCreateSql, runSeedSql - probably a good
      starting point
    - startup fails in runCreateSql, but that's probably too late - the views should be dropped at
      this point
    - since runInitSql is run before runDropSql, we could probably add an init file, drop the view
      there and enable this file only in tests
      - this should work, but doesn't seem like the cleanest solution
    - runDropSql() just executes the drop-all sql file
      (after doing some migrations-related specialties)
    - the drop file is generated in DdlGenerator.generateDdl() -> .writeDrop() ->
      .generateDropAllDdl() -> CurrentModel.getDropAllDdl()
