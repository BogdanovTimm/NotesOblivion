```shell
#!/bin/sh

#openssl req -new -x509 -keyout ca-gpolap-key -out ca-gpolap-cert -days 10000

workdir=$(readlink -f $(dirname $0))

cd $workdir

log(){
    echo $*
}

gen_cert(){
    host=$1
    domain=$2
    log "gen cert for ${host}.${domain}"
    fl_ext=$workdir/extensions.conf.tmp
    fl_config=$workdir/cert.conf.tmp
    dir_out=$workdir/$host
    fl_key=$dir_out/client.key
    fl_crt=$dir_out/client.crt
    fl_req=$dir_out/client.req
    mkdir -p $dir_out

    rm $fl_ext $fl_config 2>/dev/null
    echo "[v3_ca_${host}]" >> $fl_ext
    echo "basicConstraints = CA:FALSE" >> $fl_ext
    echo "subjectAltName = DNS:${host}.${domain}" >>$fl_ext

    echo "[req]" >>$fl_config
    echo "default_bits = 2048" >>$fl_config
    echo "prompt = no" >>$fl_config
    echo "default_md = sha256" >>$fl_config
    echo "req_extensions = req_ext" >>$fl_config
    echo "distinguished_name = dn" >>$fl_config
    echo "" >>$fl_config
    echo "[ dn ]" >>$fl_config
    echo "C=RU" >>$fl_config
    echo "ST=Pskov Region" >>$fl_config
    echo "L=Pskov" >>$fl_config
    echo "O=PJSC MTS" >>$fl_config
    echo "OU=MIS" >>$fl_config
    echo "emailAddress=Oleg.Lunkin@mts.ru" >>$fl_config
    echo "CN = ${host}.${domain}" >>$fl_config
    echo "" >>$fl_config
    echo "[ req_ext ]" >>$fl_config
    echo "subjectAltName = DNS:${host}.${domain}" >>$fl_config

    openssl req -new \
            -sha256 \
            -nodes \
            -out $fl_req \
            -newkey rsa:2048 \
            -keyout $fl_key \
            -config $fl_config 2>/dev/null
    openssl x509 -req \
            -CA ${CA}-cert \
            -CAkey ${CA}-key \
            -in $fl_req \
            -out $fl_crt \
            -days 10000 \
            -CAcreateserial \
            -extensions "v3_ca_${host}" \
            -extfile "$fl_ext" \
            -passin pass:$CA_PASS 2>/dev/null
    cp ${CA}-cert ${dir_out}/root.crt
    rm $fl_req $fl_ext $fl_config 2>/dev/null
}

CA=$1
CA_PASS=$2

if [ -z "$CA" -o -z "$CA_PASS" ]
then
    echo "run: $0 <CA name> <CA password>"
    exit 1
fi

gen_cert mis-gp-s047 pv.mts.ru
gen_cert mis-gp-s048 pv.mts.ru
gen_cert mis-gp-s049 pv.mts.ru
gen_cert mis-gp-s050 pv.mts.ru

gen_cert sasportaldb pv.mts.ru
gen_cert miscompute pv.mts.ru
gen_cert sasetl2 pv.mts.ru
gen_cert sasetl3 pv.mts.ru
gen_cert sasetl1 pv.mts.ru
gen_cert sasche pv.mts.ru
gen_cert sasae pv.mts.ru
gen_cert sastest2 pv.mts.ru
```