# Installation of the Victoria-Metrics VM-Agent

0) `uname -m` - determine whether you need to download ad64 (**x86_64**), 386 (**i368** or **i686**) or arm64 (**arm**) version
1) Download last version without **victorialogs** from [here](https://github.com/VictoriaMetrics/VictoriaMetrics/releases/)
2) `sudo    tar    xvf    /path/to/downloaded/vmagent.tar.gz    -C /usr/bin/vmagent-prod` - unpack archive
3) `sudo    groupadd    -r    victoriametrics` - create a Linux-User-Grroup
4) `sudo    useradd    -g    victoriametrics    -s    /sbin/nologin    --system victoriametrics` - create a LInux-user
5) `sudo    mkdir    /opt/vm/vmagent-remotewrite-data    -p` - create folder for temporary Victoria-Metrics VM-Agent data
6) `sudo    chown    -R    victoriametrics:victoriametrics    /opt/vm/vmagent-remotewrite-data` - change owner of folder for temporary Victoria-Metrics VM-Agent data
7) `sudo    mkdir    /etc/victoria`
8) `sudo    cp    prometheus.yaml     /etc/victoria/` - copy already-written settings for getting metrics from prometheus exporter
9) `sudo    cp    vmagent.service     /etc/systemd/system/` - copy already-written settings for systemd
10) `sudo    systemctl    daemon-reload`
11) `sudo    systemctl    enable    vmagent.service`
12) `sudo    systemctl    start     vmagent.service`
13) `sudo    systemctl    status    vmagent.service`
14) Run:

```Shell
vmagent-prod \
    -remoteWrite.url=http://vmagent.csmis.mts.ru/insert/<ид тенанта victoria>/prometheus/api/v1/write \
    -promscrape.config  '/etc/victoria/prometheus.yaml'
```
