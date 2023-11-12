# Site Address

http://timofeimen.fvds.ru

# Set server

1. Go to `securecapitaapp\src\app\service\user.service.ts` and change server IP to a needed one
2. Go to `securecapitaapp\src\app\service\customer.service.ts` and change server IP to a needed one
3. Go to `securecapitaapp` an run `ng build --configuration production` (or just use my script in VS Code)
4. Copy everything from `securecapitaapp/dist/securecapitaapp` to `securecapita/src/main/java/io/getarrays/securecapita/resources/public`
5. `maven install` (or use script in VS Code)
6. If you do this for the 1st time:
	1. Go to [Аренда VPS/VDS сервера, хостинг на виртуальном сервере | FirstVDS](https://firstvds.ru/)
	2. Go to your account [Личный кабинет - my.firstvds.ru](https://my.firstvds.ru/billmgr)
	3. "Сервер" - write in a search field
	4. Виртуальные сервера - click on it
	5. "Интсрукция" - Click on
	6. "Задать пароль" - click on
	7. Set root user password
7. Open MobaXTerm and connect to a root account using root password
8. Open `http://ServerIpv4:1500/ipsmgr`
9. Install MySQL and import a dump in it
10. `lsof -i :80` - find which program uses port 80
11. `chmod ugo+x ./securecapita-0.0.1-SNAPSHOT.jar`
12. `sudo apt update`
13. `sudo apt install openjdk-17-jdk`
14. `java -jar /var/shared/webapplication/securecapita-0.0.1-SNAPSHOT.jar --spring.datasource.password=Analsex1488! --spring.datasource.username=tim --spring.mail.password="vwku yerk hzon oltu"`
15. Add new firewall rule to open 80 port  (IP = `0.0.0.0/0` - this means that every PC in the world can send TCP or UDP signal)