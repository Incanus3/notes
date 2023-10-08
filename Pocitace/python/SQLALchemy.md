==== SQLAlchemy ====
=== Core ===
http://docs.sqlalchemy.org/en/rel_0_9/core/tutorial.html

== Connecting ==
http://docs.sqlalchemy.org/en/rel_0_9/core/connections.html

engine   = sqlalchemy.create_engine('postgresql://alto:alto@localhost/' + db)
conn     = engine.connect()

The return value of create_engine() is an instance of Engine, and it represents the core interface
to the database, adapted through a dialect that handles the details of the database and DBAPI in
use.

The first time a method like Engine.execute() or Engine.connect() is called, the Engine establishes
a real DBAPI connection to the database, which is then used to emit the SQL.

== Define and Create Tables ==
http://docs.sqlalchemy.org/en/rel_0_9/core/metadata.html
http://docs.sqlalchemy.org/en/rel_0_9/core/type_basics.html
http://docs.sqlalchemy.org/en/rel_0_9/core/defaults.html

from sqlalchemy import Table, Column, Integer, String, MetaData, ForeignKey

metadata = MetaData()

users = Table('users', metadata,
  Column('id',       Integer, primary_key=True),
  Column('name',     String),
  Column('fullname', String))

addresses = Table('addresses', metadata,
  Column('id',            Integer, primary_key=True),
  Column('user_id',       None,    ForeignKey('users.id')),
  Column('email_address', String,  nullable=False))

metadata.create_all(engine) # creates tables according to schema

== Insert Expressions ==
http://docs.sqlalchemy.org/en/rel_0_9/core/dml.html

ins = users.insert().values(name='jack', fullname='Jack Jones')

str(ins)             #=> 'INSERT INTO users (name, fullname) VALUES (:name, :fullname)'
ins.compile().params #=> {'fullname': 'Jack Jones', 'name': 'jack'}

== Executing ==
http://docs.sqlalchemy.org/en/rel_0_9/core/connections.html

conn   = engine.connect()
result = conn.execute(ins)

As the SQLAlchemy Connection object references a DBAPI connection, the result, known as a
ResultProxy object, is analogous to the DBAPI cursor object. In the case of an INSERT, we can get
important information from it, such as the primary key values which were generated from our
statement.

result.inserted_primary_key #=> [1] # returns list to support composite primary keys

== Executing Multiple Statements ==
Values can by sent directly into conn.execute().

ins = users.insert()
conn.execute(ins, id=2, name='wendy', fullname='Wendy Williams')

We can send in a list of dictionaries each containing a distinct set of parameters to be inserted.

conn.execute(addresses.insert(), [
   {'user_id': 1, 'email_address': 'jack@yahoo.com'},
   {'user_id': 1, 'email_address': 'jack@msn.com'},
   {'user_id': 2, 'email_address': 'www@www.org'},
   {'user_id': 2, 'email_address': 'wendy@aol.com'}
])

When executing multiple sets of parameters, each dictionary must have the same set of keys; i.e. you
cant have fewer keys in some dictionaries than others. This is because the Insert statement is
compiled against the first dictionary in the list, and it’s assumed that all subsequent argument
dictionaries are compatible with that statement.

== Selecting ==
http://docs.sqlalchemy.org/en/rel_0_9/core/selectable.html

from sqlalchemy.sql import select

s      = select([users])
result = conn.execute(s)

for row in result: print row
#>> (1, u'jack', u'Jack Jones')
#>> (2, u'wendy', u'Wendy Williams')

Values can be accessed by column names:

row = result.fetchone()
print "name:", row['name'], "; fullname:", row['fullname']
#>> name: jack; fullname: Jack Jones

Values can be accessed by indices:

row = result.fetchone()
print "name:", row[1], "; fullname:", row[2]
#>> name: wendy; fullname: Wendy Williams

Values can be accessed by column objects:

for row in conn.execute(s):
    print "name:", row[users.c.name], "; fullname:", row[users.c.fullname]
#>> name: jack; fullname: Jack Jones
#>> name: wendy; fullname: Wendy Williams

Close result (connection from pool) with pending rows before GC:

result.close()

Select specific columns:

s      = select([users.c.name, users.c.fullname])
result = conn.execute(s)

for row in result:
    print row
#>> (u'jack', u'Jack Jones')
#>> (u'wendy', u'Wendy Williams')

Selecting from several tables creates cross product:

for row in conn.execute(select([users, addresses])):
    print row
#>> (1, u'jack', u'Jack Jones', 1, 1, u'jack@yahoo.com')
#>> (1, u'jack', u'Jack Jones', 2, 1, u'jack@msn.com')
#>> (1, u'jack', u'Jack Jones', 3, 2, u'www@www.org')
#>> (1, u'jack', u'Jack Jones', 4, 2, u'wendy@aol.com')
#>> (2, u'wendy', u'Wendy Williams', 1, 1, u'jack@yahoo.com')
#>> (2, u'wendy', u'Wendy Williams', 2, 1, u'jack@msn.com')
#>> (2, u'wendy', u'Wendy Williams', 3, 2, u'www@www.org')
#>> (2, u'wendy', u'Wendy Williams', 4, 2, u'wendy@aol.com')

We can filter to add join condition:

s = select([users, addresses]).where(users.c.id == addresses.c.user_id)

for row in conn.execute(s):
    print row
#>> (1, u'jack', u'Jack Jones', 1, 1, u'jack@yahoo.com')
#>> (1, u'jack', u'Jack Jones', 2, 1, u'jack@msn.com')
#>> (2, u'wendy', u'Wendy Williams', 3, 2, u'www@www.org')
#>> (2, u'wendy', u'Wendy Williams', 4, 2, u'wendy@aol.com')

== Operators ==
Operators on Column objects produce BinaryExpression objects, used to generate SQL clauses:

users.c.id == addresses.c.user_id
<sqlalchemy.sql.expression.BinaryExpression object at 0x...>

str(users.c.id == addresses.c.user_id) #=> 'users.id = addresses.user_id'

With literal values, they produce bound parameters

str(users.c.id == 7)               #=> 'users.id = :id_1'
(users.c.id == 7).compile().params #=> {u'id_1': 7}

str(users.c.id != 7)               #=> 'users.id != :id_1'
str(users.c.name == None)          #=> 'users.name IS NULL'
str('fred' > users.c.name)         #=> 'users.name < :name_1' # reverse works too

Some operators depend on column types and engine

str(users.c.id + addresses.c.id)     #=> 'users.id + addresses.id'      # integer type
str(users.c.name + users.c.fullname) #=> 'users.name || users.fullname' # string type, generic engine
str((users.c.name + users.c.fullname).compile(bind=create_engine('mysql://')))
                                     #=> 'concat(users.name, users.fullname)' # string type, mysql

Custom operators can be used

str(users.c.name.op('tiddlywinks')('foo')) #=> 'users.name tiddlywinks :name_1'
somecolumn.op('&')(0xff)

Operators can also be redefined or customized:
http://docs.sqlalchemy.org/en/rel_0_9/core/custom_types.html#types-operators

== Conjunctions ==
from sqlalchemy.sql import and_, or_, not_

print and_(users.c.name.like('j%'),
           users.c.id == addresses.c.user_id,
           or_(addresses.c.email_address == 'wendy@aol.com',
               addresses.c.email_address == 'jack@yahoo.com'),
           not_(users.c.id > 5))
#>> users.name LIKE :name_1
#>> AND users.id = addresses.user_id
#>> AND (addresses.email_address = :email_address_1
#>>     OR addresses.email_address = :email_address_2)
#>> AND users.id <= :id_1

Bitwise operators are also overriden and can be used to achieve the same effect, but operator
precedence must be taken into consideration.

print users.c.name.like('j%') & (users.c.id == addresses.c.user_id) & \
      (
        (addresses.c.email_address == 'wendy@aol.com') | \
        (addresses.c.email_address == 'jack@yahoo.com')
      ) \
      & ~(users.c.id>5)

select([(users.c.fullname + ", " + addresses.c.email_address).label('title')]).\
  where(
    and_(
      users.c.id == addresses.c.user_id,
      users.c.name.between('m', 'z'),
      or_(
         addresses.c.email_address.like('%@aol.com'),
         addresses.c.email_address.like('%@msn.com')
      )))
# executes:
SELECT users.fullname || ', ' || addresses.email_address AS title
FROM users, addresses
WHERE users.id = addresses.user_id
AND users.name BETWEEN 'm' AND 'z'
AND (addresses.email_address LIKE '%@aol.com'
     OR addresses.email_address LIKE '%@msn.com')

Instead of using and_, we can also chain multiple where calls:

select([(users.c.fullname + ", " + addresses.c.email_address).label('title')]).\
  where(users.c.id == addresses.c.user_id).\
  where(users.c.name.between('m', 'z')).\
  where(or_(addresses.c.email_address.like('%@aol.com'),
            addresses.c.email_address.like('%@msn.com')))

== Literal SQL ==
from sqlalchemy.sql import text
s = text("SELECT users.fullname || ', ' || addresses.email_address AS title "
         "FROM users, addresses "
         "WHERE users.id = addresses.user_id "
         "AND users.name BETWEEN :x AND :y "
         "AND (addresses.email_address LIKE :e1 "
         "     OR addresses.email_address LIKE :e2)")
conn.execute(s, x='m', y='z', e1='%@aol.com', e2='%@msn.com').fetchall()
#=> [(u'Wendy Williams, wendy@aol.com',)]

Of course we lose the engine independence.

text can be combined with the other conjunction operators:

s = select([text("users.fullname || ', ' || addresses.email_address AS title")]).\
      where(
        and_(
          text("users.id = addresses.user_id"),
          text("users.name BETWEEN 'm' AND 'z'"),
          text("(addresses.email_address LIKE :x OR addresses.email_address LIKE :y)")
        )
      ).select_from(text('users, addresses'))
conn.execute(s, x='%@aol.com', y='%@msn.com').fetchall()
[(u'Wendy Williams, wendy@aol.com',)]

select_from needs to be used here, since SQLAlchemy can't easily determine the tables involved.

We also lose typing information about result columns and bound parameters, which is often needed to
correctly translate data values between Python and the database.
To get this information back, we can use column(), literal_column() and table() functions:

from sqlalchemy import select, and_, text, String
from sqlalchemy.sql import table, literal_column

s = select([literal_column("users.fullname", String) + ' , ' +
            literal_column("addresses.email_address").label("title")]).\
    where(
      and_(
        literal_column("users.id") == literal_column("addresses.user_id"),
        text("users.name BETWEEN 'm' AND 'z'"),
        text("(addresses.email_address LIKE :x OR addresses.email_address LIKE :y)")
      )
    ).select_from(table('users')).select_from(table('addresses'))

conn.execute(s, x='%@aol.com', y='%@msn.com').fetchall()
#=> [(u'Wendy Williams, wendy@aol.com',)]

== Ordering or Grouping by a Label ==
from sqlalchemy import func, desc

stmt = select([addresses.c.user_id,
               func.count(addresses.c.id).label('num_addresses')]).\
       order_by(desc("num_addresses"))

conn.execute(stmt).fetchall() #=> [(2, 4)]
