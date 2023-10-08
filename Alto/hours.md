Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-08-14T15:33:12+02:00

====== hours ======
Created Wednesday 14 August 2013

* vyhrady (oproti rails)
	* padrino
		* dokumentace - v guidech jsou zdokumentovane jednotlive casti, nikde ale nejsou poradne priklady toho, jak to funguje dohromady
			* napr. spoluprace controlleru a view, jak se dostanou informace z objektu do formulare u getu a z formulare do objektu pri postu/putu
			* nektere (form) helpery maji nekolik variant, ale z dokumentace nejde poradne pochopit, cim se vlastne lisi a kdy pouzit kterou
		* neni date selector
		* validace formularu si clovek musi delat sam (v post akci zpracovat, pokud jsou chyby, presmerovat zpatky na get akci, znovu vyplnit formular, ...
	* sequel
		* model_instance#save v defaultu hazi vyjimku (prestoze existuje i save!), raise_on_save_failure = false by to mela vypnout, ale nezda se fungovat

* features
	* editation and presentation of work hours - date, duration, description of work done
	* user management, login/logout, registration, hours are registered per user
	* ability to allow another user to view my hours

* database layout
	* user - id, login, password
		* many_to_many :supervizors (supervizor can see user's hours)
	* supervizor - supervizor_id, subordinate_id
	* work_day - user_id, date, hours, description

class User < Sequel::Model
  Integer user_id
  String login
  String password
  many_to_many :supervizors, :left_key => :supervizor_id, :right_key => subordinate_id, :join_table => :supervizors, :class => self
end

class Supervizor < Sequel::Model
  Integer supervizor_id
  Integer subordinate_id
end

class WorkDay < Sequel::Model
  Integer work_day_id
  Integer owner_id
  Data date
  Integer hours
  Text description
end

===== sequel many_to_many self-referential association =====
# Database schema:
#  nodes              edges
#   :id   <----------- :successor_id
#   :name       \----- :predecessor_id

class Node
  many_to_many :direct_successors, :left_key=>:successor_id,
    :right_key=>:predecessor_id, :join_table=>:edges, :class=>self
  many_to_many :direct_predecessors, :right_key=>:successor_id,
    :left_key=>:predecessor_id, :join_table=>:edges, :class=>self
end
