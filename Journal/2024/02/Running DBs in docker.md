## PostgreSQL in docker

```bash
docker run --rm --name postgres -p 5432:5432 -e POSTGRES_USER=test -e POSTGRES_PASSWORD=Passw0rd -e POSTGRES_DB=test -d postgres
```
## MS SQL in docker

```bash
docker run --rm --name mssql22 --hostname mssql22 -p 1433:1433 -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Passw0rd" -d mcr.microsoft.com/mssql/server:2022-latest
sqlcmd -C -S localhost -U SA -P "Passw0rd"
CREATE DATABASE TestDB;
go
```
## Oracle in docker
```bash
git clone https://github.com/oracle/docker-images.git -O oracle-docker-images
cd oracle-docker-images/OracleDatabase/SingleInstance/dockerfiles
./buildContainerImage.sh -v 21.3.0 -x 

docker run --rm --name oracle21 -p 1521:1521 -p 5500:5500 -e ORACLE_PWD=Passw0rd -e ORACLE_CHARACTERSET=AL32UTF8 -d oracle/database:21.3.0-xe
docker logs -f oracle21 # wait for "DATABASE IS READY TO USE!" message
```
