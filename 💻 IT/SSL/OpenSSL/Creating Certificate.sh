#!/bin/sh

# +-------------------------------------------------------------------------------------------------------------------+
# | Description: Creates certificates for servers, using given root certificate
# |--------------------------------------------------------------------------------------------------------------------
# | Prerequisites: For this script to work properly, you need to have both [*-cert] and [*-key]
# |         files of a root-certificate to be in the folder in which you run this script.
# |--------------------------------------------------------------------------------------------------------------------
# | Parameters:
# |     * CA      - [This_part] from both [This_part]-cert and [This_part]-key files of a root-certificate
# |     * CA_PASS - password for [This_part]-cert
# +--------------------------------------------------------------------------------------------------------------------








# v---------------------------------------------------- VARIABLES ----------------------------------------------------v

CA=$1
CA_PASS=$2

# ^---------------------------------------------------- VARIABLES ----------------------------------------------------^









# v---------------------------------------------------- FUNCTIONS ----------------------------------------------------v

# +----------------------------------------------------------------------------
# | Description: A simple logging
# |----------------------------------------------------------------------------
# | Parameters:
# |    * $1 - Text to write into a terminal
# +----------------------------------------------------------------------------
log() {
    echo $*
}




# +----------------------------------------------------------------------------
# | Description: Creates new Certificate
# |----------------------------------------------------------------------------
# | Parameters:
# |     * $1      - Hostname to whom to create a certificate
# |     * $2      - Domain of a hostname
# |     * CA      - Root certificate name
# |     * CA_PASS - Root certificate password
# +----------------------------------------------------------------------------
generate_certificate() {
    # v-------------------- VARIABLES --------------------v
    host=$1
    domain=$2
    fl_ext=$workdir/extensions.conf.tmp
    fl_config=$workdir/cert.conf.tmp
    dir_out=$workdir/$host
    fl_key=$dir_out/client.key
    fl_crt=$dir_out/client.crt
    fl_req=$dir_out/client.req
    # ^-------------------- VARIABLES --------------------^
    
    mkdir -p "$dir_out"
    rm "$fl_ext"  "$fl_config"  2> /dev/null

    # v--- Creating of public and private keys ---v
    {
        echo "[req]"                                  ;
        echo "default_bits = 2048"                    ;
        echo "prompt = no"                            ;
        echo "default_md = sha256"                    ;
        echo "req_extensions = req_ext"               ;
        echo "distinguished_name = dn"                ;
        echo ""                                       ;
        echo "[ dn ]"                                 ;
        echo "C=RU"                                   ;
        echo "ST=Pskov Region"                        ;
        echo "L=Pskov"                                ;
        echo "O=PJSC MTS"                             ;
        echo "OU=MIS"                                 ;
        echo "emailAddress=Oleg.Lunkin@mts.ru"        ;
        echo "CN = ${host}.${domain}"                 ;
        echo ""                                       ;
        echo "[ req_ext ]"                            ;
        echo "subjectAltName = DNS:${host}.${domain}" ;
    } >> "$fl_config"
    
    cat "$fl_config"
    
    openssl                  \
        req                  \
        -new                 \
        -sha256              \
        -nodes               \
        -out    "$fl_req"    \
        -newkey rsa:2048     \
        -keyout "$fl_key"    \
        -config "$fl_config" \
        2> /dev/null
    # ^--- Creating of public and private keys---^
    
    # v------ Creating of certificate ------v
    {
        echo "[v3_ca_${host}]"                        ;
        echo "basicConstraints = CA:FALSE"            ;
        echo "subjectAltName = DNS:${host}.${domain}" ;
    } >> "$fl_ext"
    
    openssl                             \
        x509                            \
        -req                            \
        -CA             "${CA}-cert"    \
        -CAkey          "${CA}-key"     \
        -in             "$fl_req"       \
        -out            "$fl_crt"       \
        -days           10000           \
        -CAcreateserial                 \
        -extensions     "v3_ca_${host}" \
        -extfile        "$fl_ext"       \
        -passin         "pass:$CA_PASS" \
        2> /dev/null
    # ^------ Creating of certificate ------^

    cp "${CA}-cert"  "${dir_out}/root.crt" # Saving Root certificate

    rm "$fl_req"  "$fl_ext"  "$fl_config"  2>/dev/null
}

# ^---------------------------------------------------- FUNCTIONS ----------------------------------------------------^









# v----------------------------------------------------- PROGRAM -----------------------------------------------------v

workdir=$(readlink -f $(dirname $0))
cd $workdir


if [ -z "$CA" ] || [ -z "$CA_PASS" ] ; then # Check of the arguments
    echo "Error: you need to use this script like: [$0 <CA name> <CA password>]"
    exit 1
fi

if [ ! -e "./${CA}-cert" ] || [ ! -e "./${CA}-key" ] ; then # Check whether files exist in [./]
    echo "Error: you need to have both [./${CA}-cert] and [./${CA}-cert] files in this folder"
    exit 1
fi

#---------------------------------------
#                    |  host  | domain
#---------------------------------------
generate_certtificate sastest2 pv.mts.ru
generate_certtificate sastest3 pv.mts.ru

# ^----------------------------------------------------- PROGRAM -----------------------------------------------------^
