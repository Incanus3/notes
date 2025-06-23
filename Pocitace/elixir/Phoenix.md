### Starting new project
```
mix archive.install hex phx_new 1.8.0-rc.3
mix help phx.new
mix phx.new gitlab_graphs
cd gitlab_graphs/
cp ../elizar/run_postgres.sh .
vim run_postgres.sh # edit name
./run_postgres.sh 
mix phx.gen.auth Accounts User users --hashing-lib argon2
mix phx.gen.live Test Resource resources name:string age:integer
mix setup
mix test
mix phx.server
```