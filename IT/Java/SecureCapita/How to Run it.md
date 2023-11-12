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