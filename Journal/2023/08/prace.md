== faktura ==

- prohlizec a pruzkumnik semantickych siti - 82h
- mass edit - pridat/odebrat u multi-value slotu - 25h
- mass workflow transition - 25h
- import/export do file-storage - 25h

- dohromady - 114
- ma byt 157

== Dokumenty do template ==

[*] cislovani podkapitol
[ ] moznost collapsovat kapitoly
[ ] parsovat mrtvy text v live text slotech jako html a prevest ho na komponenty


org.postgresql.util.PSQLException: Cannot rollback when autoCommit is enabled.
        at org.postgresql.jdbc.PgConnection.rollback(PgConnection.java:893) ~[postgresql-42.3.4.jar!/:42.3.4]
        at io.ebean.datasource.pool.PooledConnection.rollback(PooledConnection.java:651) ~[ebean-datasource-8.5.jar!/:8.5]
        at io.ebean.util.JdbcClose.rollback(JdbcClose.java:64) ~[ebean-api-13.20.1.jar!/:13.20.1]
        at io.ebeaninternal.dbmigration.DdlGenerator.runDdl(DdlGenerator.java:115) ~[ebean-ddl-generator-13.20.1.jar!/:13.20.1]
        at io.ebeaninternal.dbmigration.DdlGenerator.execute(DdlGenerator.java:89) ~[ebean-ddl-generator-13.20.1.jar!/:13.20.1]
        at io.ebeaninternal.server.core.DefaultServer.executePlugins(DefaultServer.java:193) ~[ebean-core-13.20.1.jar!/:13.20.1]
        at io.ebeaninternal.server.core.DefaultContainer.startServer(DefaultContainer.java:145) ~[ebean-core-13.20.1.jar!/:13.20.1]
        at io.ebeaninternal.server.core.DefaultContainer.createServer(DefaultContainer.java:108) ~[ebean-core-13.20.1.jar!/:13.20.1]
        at io.ebeaninternal.server.core.DefaultContainer.createServer(DefaultContainer.java:29) ~[ebean-core-13.20.1.jar!/:13.20.1]
        at io.ebean.DatabaseFactory.createInternal(DatabaseFactory.java:136) ~[ebean-api-13.20.1.jar!/:13.20.1]
        at io.ebean.DatabaseFactory.create(DatabaseFactory.java:85) ~[ebean-api-13.20.1.jar!/:13.20.1]
        at cz.sentica.qwazar.semantic.configuration.SemanticPersistenceConfiguration.semanticDatabase(SemanticPersistenceConfiguration.kt:53) ~[backend-apps-semantic-nets-3.0.0-plain.jar!/:na]
        at cz.sentica.qwazar.semantic.configuration.SemanticPersistenceConfiguration$$EnhancerBySpringCGLIB$$79d331eb.CGLIB$semanticDatabase$0(<generated>) ~[backend-apps-semantic-nets-3.0.0-plain.jar!/:na]
        at cz.sentica.qwazar.semantic.configuration.SemanticPersistenceConfiguration$$EnhancerBySpringCGLIB$$79d331eb$$FastClassBySpringCGLIB$$d4370830.invoke(<generated>) ~[backend-apps-semantic-nets-3.0.0-plain.jar!/:na]
        at org.springframework.cglib.proxy.MethodProxy.invokeSuper(MethodProxy.java:244) ~[spring-core-5.3.29.jar!/:5.3.29]
        at org.springframework.context.annotation.ConfigurationClassEnhancer$BeanMethodInterceptor.intercept(ConfigurationClassEnhancer.java:331) ~[spring-context-5.3.29.jar!/:5.3.29]
        at cz.sentica.qwazar.semantic.configuration.SemanticPersistenceConfiguration$$EnhancerBySpringCGLIB$$79d331eb.semanticDatabase(<generated>) ~[backend-apps-semantic-nets-3.0.0-plain.jar!/:na]
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method) ~[na:na]
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:77) ~[na:na]
        at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) ~[na:na]
        at java.base/java.lang.reflect.Method.invoke(Method.java:568) ~[na:na]
        at org.springframework.beans.factory.support.SimpleInstantiationStrategy.instantiate(SimpleInstantiationStrategy.java:154) ~[spring-beans-5.3.29.jar!/:5.3.29]
        at org.springframework.beans.factory.support.ConstructorResolver.instantiate(ConstructorResolver.java:653) ~[spring-beans-5.3.29.jar!/:5.3.29]
        at org.springframework.beans.factory.support.ConstructorResolver.instantiateUsingFactoryMethod(ConstructorResolver.java:638) ~[spring-beans-5.3.29.jar!/:5.3.29]
        at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.instantiateUsingFactoryMethod(AbstractAutowireCapableBeanFactory.java:1352) ~[spring-beans-5.3.29.jar!/:5.3.29]
        at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBeanInstance(AbstractAutowireCapableBeanFactory.java:1195) ~[spring-beans-5.3.29.jar!/:5.3.29]
        at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean(AbstractAutowireCapableBeanFactory.java:582) ~[spring-beans-5.3.29.jar!/:5.3.29]
        at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBean(AbstractAutowireCapableBeanFactory.java:542) ~[spring-beans-5.3.29.jar!/:5.3.29]
        at org.springframework.beans.factory.support.AbstractBeanFactory.lambda$doGetBean$0(AbstractBeanFactory.java:335) ~[spring-beans-5.3.29.jar!/:5.3.29]
        at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.getSingleton(DefaultSingletonBeanRegistry.java:234) ~[spring-beans-5.3.29.jar!/:5.3.29]
        at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:333) ~[spring-beans-5.3.29.jar!/:5.3.29]
        at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:208) ~[spring-beans-5.3.29.jar!/:5.3.29]
        at org.springframework.beans.factory.config.DependencyDescriptor.resolveCandidate(DependencyDescriptor.java:276) ~[spr
