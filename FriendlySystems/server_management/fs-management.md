Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-10-04T15:19:21+02:00

====== fs-management ======
Created Friday 04 October 2013

emaiů: admin@admin.cz
heslo: aaa12345A

===== vosovo schema =====
 create_table "messages", :force => true do |t|
	t.integer "messageable_id"
	t.string "messageable_type"
	t.datetime "created_at", :null => false
	t.datetime "updated_at", :null => false
	t.string "state"
	t.boolean "sent_to_server"               # bude smazano, je zakodovano ve state
	t.boolean "received_by_server"      # 
	t.string "group"
	t.string "run_on"
	t.string "messageable_action"
	t.text "parameters"
end

==== zpravy vytvorene pri vytvoreni databazoveho uzivatele ====
'''
1.9.3p448 :008 > Message.select("id,state,`group`,run_on,messageable_action,parameters").last(15)
  Message Load (0.6ms)  SELECT id,state,`group`,run_on,messageable_action,parameters FROM `messages` ORDER BY id DESC LIMIT 15
+----+----------+-------+--------+--------------------+------------------------------------------------------------------------------------+
| id | state    | group | run_on | messageable_action | parameters                                                                         |
+----+----------+-------+--------+--------------------+------------------------------------------------------------------------------------+
| 51 | accepted | mysql | master | create             | {"username"=>"test", "password_hash"=>"*2A4C685A61E0565C013686DB199EB18865055C98"} |
| 52 | accepted | mysql | all    | create             | {"level"=>1, "database_name"=>"northwind", "username"=>"test"}                     |
| 53 | accepted | mysql | all    | create             | {"level"=>0, "database_name"=>"zamestnanci", "username"=>"test"}                   |
| 54 | accepted | mysql | all    | create             | {"level"=>0, "database_name"=>"finventory", "username"=>"test"}                    |
| 55 | accepted | mysql | all    | create             | {"level"=>0, "database_name"=>"ssk", "username"=>"test"}                           |
| 56 | accepted | mysql | all    | create             | {"level"=>0, "database_name"=>"olomouc", "username"=>"test"}                       |
| 57 | accepted | mysql | all    | create             | {"level"=>0, "database_name"=>"proste_databaze", "username"=>"test"}               |
| 58 | accepted | mysql | all    | create             | {"level"=>0, "database_name"=>"upcko", "username"=>"test"}                         |
| 59 | accepted | mysql | all    | create             | {"level"=>0, "database_name"=>"zoo", "username"=>"test"}                           |
| 60 | accepted | mysql | all    | create             | {"level"=>0, "database_name"=>"vlakova_stanice", "username"=>"test"}               |
| 61 | accepted | mysql | all    | create             | {"level"=>2, "database_name"=>"auta", "username"=>"test"}                          |
| 62 | accepted | mysql | all    | create             | {"level"=>0, "database_name"=>"beatles_fans", "username"=>"test"}                  |
| 63 | accepted | mysql | all    | create             | {"level"=>0, "database_name"=>"hmyzi_svet", "username"=>"test"}                    |
| 64 | accepted | mysql | all    | create             | {"level"=>0, "database_name"=>"oldies_bands", "username"=>"test"}                  |
| 65 | accepted | mysql | all    | create             | {"level"=>0, "database_name"=>"uplna", "username"=>"test"}                         |
+----+----------+-------+--------+--------------------+------------------------------------------------------------------------------------+
15 rows in set
'''
