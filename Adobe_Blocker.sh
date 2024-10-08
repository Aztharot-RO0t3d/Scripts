#!/bin/bash

if [ "$EUID" -ne 0 ]; then
	echo "Por Favor, ejecuta el script como superusuario (sudo)."
	exit
fi

HOSTS_FILE="/private/etc/hosts"

cp "$HOSTS_FILE" "$HOSTS_FILE.bak"
echo "Se ha creado una copia de seguridad en $HOSTS_FILE.bak ."

BLOCK_ENTRIES="
#Bloqueo de servidores y DNS de Adobe
#
0.0.0.0  192.150.18.108
0.0.0.0  192.150.22.40
0.0.0.0  192.150.14.69
0.0.0.0  192.150.8.118
0.0.0.0  192.150.8.100
0.0.0.0  192.150.18.101
0.0.0.0  192.168.112.207
0.0.0.0  194.224.66.48
0.0.0.0  199.7.52.190
0.0.0.0  199.7.52.190:80
0.0.0.0  209.34.83.73:43
0.0.0.0  209.34.83.73:443
0.0.0.0  www.adobeereg.com #75.125.24.83
0.0.0.0  adobeereg.com #207.66.2.10
0.0.0.0  activate.adobe.com  #192.150.22.40
0.0.0.0  practivate.adobe
0.0.0.0  practivate.adobe.com
0.0.0.0  practivate.adobe.*
0.0.0.0  practivate.adobe.com #192.150.18.54
0.0.0.0  practivate.adobe.newoa
0.0.0.0  practivate.adobe.ntp
0.0.0.0  practivate.adobe.ipp
0.0.0.0  activate-sea.adobe.com #192.150.22.40
0.0.0.0  wip.adobe.com
0.0.0.0  wip1.adobe.com
0.0.0.0  wip2.adobe.com
0.0.0.0  wip3.adobe.com #192.150.8.60
0.0.0.0  wip4.adobe.com #192.150.18.200
0.0.0.0  lmlicenses.wip1.adobe.com
0.0.0.0  lmlicenses.wip2.adobe.com
0.0.0.0  lmlicenses.wip3.adobe.com
0.0.0.0  lmlicenses.wip4.adobe.com
0.0.0.0  activate.wip.adobe.com
0.0.0.0  activate.wip1.adobe.com
0.0.0.0  activate.wip2.adobe.com
0.0.0.0  activate.wip3.adobe.com #192.150.22.40
0.0.0.0  activate.wip4.adobe.com #192.150.22.40
0.0.0.0  ereg.wip.adobe.com
0.0.0.0  ereg.wip1.adobe.com
0.0.0.0  ereg.wip2.adobe.com
0.0.0.0  ereg.wip3.adobe.com #192.150.18.63
0.0.0.0  ereg.wip4.adobe.com #192.150.18.103
0.0.0.0  ereg.adobe.com #192.150.18.103
0.0.0.0  3dns.adobe.com
0.0.0.0  3dns-1.adobe.com
0.0.0.0  3dns-2.adobe.com #192.150.22.22
0.0.0.0  3dns-3.adobe.com #192.150.14.21
0.0.0.0  3dns-4.adobe.com #192.150.18.247
0.0.0.0  3dns-5.adobe.com #192.150.22.46
0.0.0.0  adobe-dns.adobe.com #192.150.11.30
0.0.0.0  adobe-dns-1.adobe.com
0.0.0.0  adobe-dns-2.adobe.com #192.150.11.247
0.0.0.0  adobe-dns-3.adobe.com #192.150.22.30
0.0.0.0  adobe-dns-4.adobe.com
0.0.0.0  wwis-dubc1-vip60.adobe.com
0.0.0.0  activate-sjc0.adobe.com #192.150.14.69
0.0.0.0  hl2rcv.adobe.com #192.150.14.174
0.0.0.0  adobe.activate.com
0.0.0.0  lm.licenses.adobe.com
0.0.0.0  na1r.services.adobe.com
0.0.0.0  hlrcv.stage.adobe.com
0.0.0.0  na2m-pr.licenses.adobe.com
0.0.0.0  adobe.tt.omtrdc.net
0.0.0.0  adobe.activate.com #69.175.22.26
# End of main entries present above
# New additional entries go below this comment
0.0.0.0  wwis-dubc1-vip30.adobe.com #192.150.8.30
0.0.0.0  wwis-dubc1-vip31.adobe.com #192.150.8.31
0.0.0.0  wwis-dubc1-vip32.adobe.com #192.150.8.32
0.0.0.0  wwis-dubc1-vip33.adobe.com #192.150.8.33
0.0.0.0  wwis-dubc1-vip34.adobe.com #192.150.8.34
0.0.0.0  wwis-dubc1-vip35.adobe.com #192.150.8.35
0.0.0.0  wwis-dubc1-vip36.adobe.com #192.150.8.36
0.0.0.0  wwis-dubc1-vip37.adobe.com #192.150.8.37
0.0.0.0  wwis-dubc1-vip38.adobe.com #192.150.8.38
0.0.0.0  wwis-dubc1-vip39.adobe.com #192.150.8.39
0.0.0.0  wwis-dubc1-vip40.adobe.com #192.150.8.40
0.0.0.0  wwis-dubc1-vip41.adobe.com #192.150.8.41
0.0.0.0  wwis-dubc1-vip42.adobe.com #192.150.8.42
0.0.0.0  wwis-dubc1-vip43.adobe.com #192.150.8.43
0.0.0.0  wwis-dubc1-vip44.adobe.com #192.150.8.44
0.0.0.0  wwis-dubc1-vip45.adobe.com #192.150.8.45
0.0.0.0  wwis-dubc1-vip46.adobe.com #192.150.8.46
0.0.0.0  wwis-dubc1-vip47.adobe.com #192.150.8.47
0.0.0.0  wwis-dubc1-vip48.adobe.com #192.150.8.48
0.0.0.0  wwis-dubc1-vip49.adobe.com #192.150.8.49
0.0.0.0  wwis-dubc1-vip50.adobe.com #192.150.8.50
0.0.0.0  wwis-dubc1-vip51.adobe.com #192.150.8.51
0.0.0.0  wwis-dubc1-vip52.adobe.com #192.150.8.52
0.0.0.0  wwis-dubc1-vip53.adobe.com #192.150.8.53
0.0.0.0  wwis-dubc1-vip54.adobe.com #192.150.8.54
0.0.0.0  wwis-dubc1-vip55.adobe.com #192.150.8.55
0.0.0.0  wwis-dubc1-vip56.adobe.com #192.150.8.56
0.0.0.0  wwis-dubc1-vip57.adobe.com #192.150.8.57
0.0.0.0  wwis-dubc1-vip58.adobe.com #192.150.8.58
0.0.0.0  wwis-dubc1-vip59.adobe.com #192.150.8.59
0.0.0.0  wwis-dubc1-vip60.adobe.com #192.160.8.60
0.0.0.0  wwis-dubc1-vip61.adobe.com #192.160.8.61
0.0.0.0  wwis-dubc1-vip62.adobe.com #192.160.8.62
0.0.0.0  wwis-dubc1-vip63.adobe.com #192.160.8.63
0.0.0.0  wwis-dubc1-vip64.adobe.com #192.160.8.64
0.0.0.0  wwis-dubc1-vip65.adobe.com #192.160.8.65
0.0.0.0  wwis-dubc1-vip66.adobe.com #192.160.8.66
0.0.0.0  wwis-dubc1-vip67.adobe.com #192.160.8.67
0.0.0.0  wwis-dubc1-vip68.adobe.com #192.160.8.68
0.0.0.0  wwis-dubc1-vip69.adobe.com #192.160.8.69
0.0.0.0  wwis-dubc1-vip70.adobe.com #192.170.8.70
0.0.0.0  wwis-dubc1-vip71.adobe.com #192.170.8.71
0.0.0.0  wwis-dubc1-vip72.adobe.com #192.170.8.72
0.0.0.0  wwis-dubc1-vip73.adobe.com #192.170.8.73
0.0.0.0  wwis-dubc1-vip74.adobe.com #192.170.8.74
0.0.0.0  wwis-dubc1-vip75.adobe.com #192.170.8.75
0.0.0.0  wwis-dubc1-vip76.adobe.com #192.170.8.76
0.0.0.0  wwis-dubc1-vip77.adobe.com #192.170.8.77
0.0.0.0  wwis-dubc1-vip78.adobe.com #192.170.8.78
0.0.0.0  wwis-dubc1-vip79.adobe.com #192.170.8.79
0.0.0.0  wwis-dubc1-vip80.adobe.com #192.180.8.80
0.0.0.0  wwis-dubc1-vip81.adobe.com #192.180.8.81
0.0.0.0  wwis-dubc1-vip82.adobe.com #192.180.8.82
0.0.0.0  wwis-dubc1-vip83.adobe.com #192.180.8.83
0.0.0.0  wwis-dubc1-vip84.adobe.com #192.180.8.84
0.0.0.0  wwis-dubc1-vip85.adobe.com #192.180.8.85
0.0.0.0  wwis-dubc1-vip86.adobe.com #192.180.8.86
0.0.0.0  wwis-dubc1-vip87.adobe.com #192.180.8.87
0.0.0.0  wwis-dubc1-vip88.adobe.com #192.180.8.88
0.0.0.0  wwis-dubc1-vip89.adobe.com #192.180.8.89
0.0.0.0  wwis-dubc1-vip90.adobe.com #192.190.8.90
0.0.0.0  wwis-dubc1-vip91.adobe.com #192.190.8.91
0.0.0.0  wwis-dubc1-vip92.adobe.com #192.190.8.92
0.0.0.0  wwis-dubc1-vip93.adobe.com #192.190.8.93
0.0.0.0  wwis-dubc1-vip94.adobe.com #192.190.8.94
0.0.0.0  wwis-dubc1-vip95.adobe.com #192.190.8.95
0.0.0.0  wwis-dubc1-vip96.adobe.com #192.190.8.96
0.0.0.0  wwis-dubc1-vip97.adobe.com #192.190.8.97
0.0.0.0  wwis-dubc1-vip98.adobe.com #192.190.8.98
0.0.0.0  wwis-dubc1-vip99.adobe.com #192.190.8.99
0.0.0.0  wwis-dubc1-vip100.adobe.com #192.190.8.100
0.0.0.0  wwis-dubc1-vip101.adobe.com #192.190.8.101
0.0.0.0  wwis-dubc1-vip102.adobe.com #192.190.8.102
0.0.0.0  wwis-dubc1-vip103.adobe.com #192.190.8.103
0.0.0.0  wwis-dubc1-vip104.adobe.com #192.190.8.104
0.0.0.0  wwis-dubc1-vip105.adobe.com #192.150.8.105
0.0.0.0  wwis-dubc1-vip106.adobe.com #192.150.8.106
0.0.0.0  wwis-dubc1-vip107.adobe.com #192.150.8.107
0.0.0.0  wwis-dubc1-vip108.adobe.com #192.150.8.108
0.0.0.0  wwis-dubc1-vip109.adobe.com #192.150.8.109
0.0.0.0  wwis-dubc1-vip110.adobe.com #192.150.8.110
0.0.0.0  wwis-dubc1-vip111.adobe.com #192.150.8.111
0.0.0.0  wwis-dubc1-vip112.adobe.com #192.150.8.112
0.0.0.0  wwis-dubc1-vip113.adobe.com #192.150.8.113
0.0.0.0  wwis-dubc1-vip114.adobe.com #192.150.8.114
0.0.0.0  wwis-dubc1-vip115.adobe.com #192.150.8.115
0.0.0.0  wwis-dubc1-vip116.adobe.com #192.150.8.116
0.0.0.0  wwis-dubc1-vip117.adobe.com #192.150.8.117
0.0.0.0  wwis-dubc1-vip118.adobe.com #192.150.8.118
0.0.0.0  wwis-dubc1-vip119.adobe.com #192.150.8.119
0.0.0.0  wwis-dubc1-vip120.adobe.com #192.150.8.120
0.0.0.0  wwis-dubc1-vip121.adobe.com #192.150.8.121
0.0.0.0  wwis-dubc1-vip122.adobe.com #192.150.8.122
0.0.0.0  wwis-dubc1-vip123.adobe.com #192.150.8.123
0.0.0.0  wwis-dubc1-vip124.adobe.com #192.150.8.124
0.0.0.0  wwis-dubc1-vip125.adobe.com #192.150.8.125
0.0.0.0  genuine.adobe.com
0.0.0.0  assets.adobedtm.com
0.0.0.0  cc-api-data.adobe.io
0.0.0.0  ic.adobe.io
0.0.0.0  lcs-robs.adobe.io
0.0.0.0  cc-api-data.adobe.io
0.0.0.0  cc-api-data-stage.adobe.io
0.0.0.0  prod.adobegenuine.com
#
"

echo "$BLOCK_ENTRIES" >> "$HOSTS_FILE"

echo "Se han excluido a todos los servidores de ADOBE con exito en el archivo HOSTS."

exit 0
