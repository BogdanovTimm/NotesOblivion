#                  Install Master KDC aka admin_server

1. `sudo yum install -y krb5-server`
2. `sudo vim /var/kerberos/krb5kdc/kdc.conf` - open Kerberos settings file and write this:
    ```Ruby
    [kdcdefaults]
     kdc_ports     = 88              # UDP-Port to work with this Kafka-Broker
     kdc_tcp_ports = 88              # TCP-Port to work with this Kafka-Broker
     default_realm = ADS-KAFKA.LOCAL # Default Kafka-Realm

    [realms]
     ADS-KAFKA.LOCAL = {
     acl_file           = /var/kerberos/krb5kdc/kadm5.acl        # File with Principals and their permissions
     dict_file          = /usr/share/dict/words                 # File with words that can't be used as passwords
     admin_keytab       = /var/kerberos/krb5kdc/kadm5.keytab # ???
     supported_enctypes = aes256-cts:normal aes128-cts:normal des3-hmac-sha1:normal arcfour-hmac:normal camellia256-cts:normal camellia128-cts:normal des-hmac-sha1:normal des-cbc-md5:normal des-cbc-crc:normal # Encryptors that Kerberos may use
    }
    ```
3. `sudo vim /var/kerberos/krb5kdc/kadm5.acl` - settings for administrator access:
    ```Ruby
    */admin@ADS-KAFKA.LOCAL      * # Every principal/admin@ADS-KAFKA.LOCAL have all admin permissions (except getting keys)
    ```
4. `sudo vim /etc/krb5.conf` - open Kerberos domain settings:
    ```Ruby
    [logging]
     kdc          = FILE:/var/log/krb5kdc.log  # Logs for KDC
     admin_server = FILE:/var/log/kadmind.log  # Logs for admin server
     default      = FILE:/var/log/krb5libs.log # Logs for everything else
    
    [libdefaults]
     default_realm   = ADS-KAFKA.LOCAL # Default Realsm for principals when you try to get tickets on a user side
     kdc_timesync    = 1               # Whether or not to check timesync between user and KDC
     ticket_lifetime = 24h             # I think it is self-explanatory

    [realms]
     ADS-KAFKA.LOCAL = {
     admin_server = sov-test-5.ru-central1.internal # admin_server host
     kdc          = sov-test-5.ru-central1.internal # KDC host
     }
    ```
5. `sudo /usr/sbin/kdb5_util create -s -r ADS-KAFKA.LOCAL -P your_password` - Create **Database** for ADS-KAFKA.LOCAL
6. `sudo kadmin.local -q "add_principal -pw your_password username/admin"` - create admin principal
7. `sudo systemctl restart krb5kdc`
8. `sudo systemctl restart kadmin`
9. `sudo systemctl status krb5kdc`
10. `sudo systemctl status kadmin`









#                  Install Kerberos on User PC

##                 Way 1

1. `sudo apt-get install krb5-user` - install it on user PC
2. `kinit -f username` - run on user PC and get your 1st ticket!


##                 Way 2

1. Install the `krb5-libs` and `krb5-workstation` packages on all of the client machines.
2. Supply a valid `/etc/krb5.conf` file for each client (usually this can be the same krb5.conf file used by the KDC).
3. To use kerberized `rsh` and `rlogin` services, install the `rsh` package
4. `addprinc -randkey host/server.example.com` - Using `kadmin`, add a host principal for the workstation on the KDC. The instance in this case is the hostname of the workstation. Use the `-randkey` option for the kadmin's addprinc command to create the principal and assign it a random key
5. `ktadd -k /etc/krb5.keytab host/server.example.com` - The keys can be extracted for the workstation by running `kadmin` on the workstation itself and using the `ktadd` command.










#                  Install Secondary KDCs

1. Copy the master KDC's `krb5.conf` (`/etc/krb5.conf`) and `kdc.conf` (`/var/kerberos/krb5kdc/kdc.conf`) files to the secondary KDC.
2. `kadmin.local -r EXAMPLE.COM` - start from a root shell on the Master KDC
3. `add_principal -randkey host/masterkdc.example.com` - create a new entry for the master KDC's host service.
4. `ktadd host/masterkdc.example.com` - set a random key for the service and store the random key in the master's default keytab file. This key is used by the `kprop` command to authenticate to the secondary servers. You will only need to do this once, regardless of how many secondary KDC servers you install.
5. `kadmin -p jsmith/admin@EXAMPLE.COM -r EXAMPLE.COM` - start kadmin on the Seconadry PC
6. `add_principal -randkey host/slavekdc.example.com` - create a new enty for the Secondary KDC's host service
7. `ktadd host/slavekdc.example.com@EXAMPLE.COM` - set a ranom key for the service and store the random key in the Secondary KDC server's default keytab file.  This key is used by the kpropd service when authenticating clients.
8. `vim /var/kerberos/krb5kdc/kpropd.acl` - Obviously, not all potential clients should be allowed to provide the `kprop` service with a new realm database. To restrict access, the `kprop` service on the secondary KDC will only accept updates from clients whose principal names are listed in this file:
    ```
    host/masterkdc.example.com@EXAMPLE.COM
    ```
9. Once the secondary KDC has obtained a copy of the database, it will also need the master key which was used to encrypt it. If the KDC database's master key is stored in a stash file on the master KDC (typically named /var/kerberos/krb5kdc/.k5.REALM), either copy it to the secondary KDC using any available secure method, or create a dummy database and identical stash file on the secondary KDC by running kdb5_util create -s and supplying the same password. The dummy database will be overwritten by the first successful database propagation.
10. Ensure that the secondary KDC's firewall allows the master KDC to contact it using TCP on port 754 (krb5_prop)
11. start the `kprop` service
12. Double-check that the `kadmin` service is disabled
13. `/usr/sbin/kdb5_util dump /var/kerberos/krb5kdc/slave_datatrans` - Perform a manual database propagation test by dumping the realm database on the master KDC to the default data file which the kprop command will read (/var/kerberos/krb5kdc/slave_datatrans).
14. `kprop slavekdc.example.com` - Use the kprop command to transmit its contents to the secondary KDC.
15. Using `kinit`, verify that the client system is able to correctly obtain the initial credentials from the KDC. The `/etc/krb5.conf` for the client should list only the secondary KDC in its list of KDCs.
16. Create a script which dumps the realm database and runs the `kprop` command to transmit the database to each secondary KDC in turn, and configure the `cron` service to run the script periodically.