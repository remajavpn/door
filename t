#!/bin/bash
# ******************************************
# Program: inject69 Servis inject69 2017
# Website: inject69.tk
# Developer: inject69
# Nickname: inject69
# Date: 22-07-2016
# Last Updated: 22-08-2017
# ******************************************
# MULA SETUP
myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;
if [ $USER != 'root' ]; then
echo "Sorry, for run the script please using root user"
exit 1
fi
if [[ "$EUID" -ne 0 ]]; then
echo "Sorry, you need to run this as root"
exit 2
fi
if [[ ! -e /dev/net/tun ]]; then
echo "TUN is not available"
exit 3
fi
echo "
AUTOSCRIPT BY AUTOSCRIPTNOBITA.TK
AMBIL PERHATIAN !!!"
clear
echo "MULA SETUP"
clear
echo "SET TIMEZONE KUALA LUMPUT GMT +8"
ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime;
clear
echo "
ENABLE IPV4 AND IPV6
SILA TUNGGU SEDANG DI SETUP
"
echo ipv4 >> /etc/modules
echo ipv6 >> /etc/modules
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
sed -i 's/#net.ipv6.conf.all.forwarding=1/net.ipv6.conf.all.forwarding=1/g' /etc/sysctl.conf
sysctl -p
clear
echo "
MEMBUANG SPAM PACKAGE
"
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove sendmail*;
apt-get -y --purge remove postfix*;
apt-get -y --purge remove bind*;
clear
echo "
"
sh -c 'echo "deb http://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list'
wget -qO - http://www.webmin.com/jcameron-key.asc | apt-key add -
apt-get update;
apt-get -y autoremove;
apt-get -y install wget curl;
echo "
"
# text gambar
apt-get install boxes

# color text
cd
rm -rf /root/.bashrc
wget -O /root/.bashrc "https://raw.githubusercontent.com/macisvpn/premiumnow/master/menu/.bashrc"

# install lolcat
sudo apt-get -y install ruby
sudo gem install lolcat
# script
wget -O /etc/pam.d/common-password "https://raw.githubusercontent.com/macisvpn/premiumnow/master/common-password"
chmod +x /etc/pam.d/common-password
# fail2ban & exim & protection
# apt-get -y install fail2ban sysv-rc-conf dnsutils dsniff zip unzip;
# wget https://github.com/jgmdev/ddos-deflate/archive/master.zip;unzip master.zip;
# cd ddos-deflate-master && ./install.sh
service exim4 stop;sysv-rc-conf exim4 off;
# webmin
apt-get -y install webmin
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf

# setting port ssh
sed -i 's/Port 22/Port 22/g' /etc/ssh/sshd_config

# install sslh
apt-get -y install sslh
echo ' 
RUN=yes
DAEMON=/usr/sbin/sslh
DAEMON_OPTS="-u sslh -p 0.0.0.0:444 --ssh 127.0.0.1:22 --openvpn 127.0.0.1:443 --openvpn 127.0.0.1:1194 -P /var/run/sslh/sslh.pid" ' > /etc/default/sslh
echo '
iptables -t mangle -N SSLH
iptables -t mangle -A OUTPUT --protocol tcp --out-interface eth0 --sport 22 --jump SSLH
iptables -t mangle -A OUTPUT --protocol tcp --out-interface eth0 --sport 143 --jump SSLH
iptables -t mangle -A OUTPUT --protocol tcp --out-interface eth0 --sport 443 --jump SSLH
iptables -t mangle -A OUTPUT --protocol tcp --out-interface eth0 --sport 587 --jump SSLH
iptables -t mangle -A OUTPUT --protocol tcp --out-interface eth0 --sport 1194 --jump SSLH
iptables -t mangle -A SSLH --jump MARK --set-mark 0x1
iptables -t mangle -A SSLH --jump ACCEPT ' >> /etc/rc.local
service sslh start

# install dropbear
apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=444/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
/etc/init.d/dropbear restart

# install squid3
wget https://raw.githubusercontent.com/kingmapualaut/AAAAAA/main/prx.sh
chmod +x prx.sh
./prx.sh

# install webserver
apt-get -y install nginx libexpat1-dev libxml-parser-perl

# install essential package
apt-get -y install nano iptables-persistent dnsutils screen whois ngrep unzip unrar

# install ddos deflate
cd
apt-get -y install dnsutils dsniff
wget https://raw.githubusercontent.com/redeviver/script/master/ddos-deflate-master.zip
unzip ddos-deflate-master.zip
cd ddos-deflate-master
./install.sh
rm -rf /root/ddos-deflate-master.zip

# install webserver
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/redeviver/script/master/nginx.conf"
mkdir -p /home/vps/public_html
wget -O /home/vps/public_html/index.html "https://raw.githubusercontent.com/redeviver/script/master/index.html" > /home/vps/public_html/index.html
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/remajavpn/door/main/vps.conf"
service nginx restart

#  openvpn
apt-get -y install openvpn
cd /etc/openvpn/
wget -O openvpn.tar "https://gakod.com/debian/all/openvpn.tar"
tar xf openvpn.tar;rm openvpn.tar
wget -O /etc/rc.local "https://raw.githubusercontent.com/guardeumvpn/Qwer77/master/rc.local"
chmod +x /etc/rc.local
# etc
wget -O /home/vps/public_html/client.ovpn "https://gakod.com/debian/all/client.ovpn"
wget -O /home/vps/public_html/udp.ovpn "https://gakod.com/debian/all/udp.ovpn"
wget -O /home/vps/public_html/client1.ovpn "https://raw.githubusercontent.com/BangJaguh/VPN/main/c/client1.ovpn"
wget -O /home/vps/public_html/client3.ovpn "https://gakod.com/debian/client3.ovpn"
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
sed -i "s/ipserver/$myip/g" /home/vps/public_html/client.ovpn
sed -i "s/ipserver/$myip/g" /home/vps/public_html/udp.ovpn
sed -i "s/ipserver/$myip/g" /home/vps/public_html/client1.ovpn
sed -i "s/ipserver/$myip/g" /home/vps/public_html/client3.ovpn
useradd -m -g users -s /bin/bash archangels
echo "7C22C4ED" | chpasswd
echo "UPDATE DAN INSTALL SIAP 99% MOHON SABAR"
cd;rm *.sh;rm *.txt;rm *.tar;rm *.deb;rm *.asc;rm *.zip;rm ddos*;
 
# install stunnel
apt-get -y install stunnel4
cat > /etc/stunnel/stunnel.conf <<-END
cert = /etc/stunnel/stunnel.pem
pid = /stunnel.pid

client = no	
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
accept = 442
connect = 127.0.0.1:443
connect = 127.0.0.1:109
connect = 127.0.0.1:110

[ssh]
accept = 21
connect = 127.0.0.1:143

[openvpn]
accept = 587
connect = 127.0.0.1:443
END

#membuat sertifikat
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem

#konfigurasi stunnel
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
/etc/init.d/stunnel4 restart

# install vnstat gui
cd /home/vps/public_html/
wget https://raw.githubusercontent.com/sslmode/sslmode/master/vnstat_php_frontend-1.5.1.tar.gz
tar xf vnstat_php_frontend-1.5.1.tar.gz
rm vnstat_php_frontend-1.5.1.tar.gz
mv vnstat_php_frontend-1.5.1 vnstat
cd vnstat
sed -i "s/\$iface_list = array('eth0', 'sixxs');/\$iface_list = array('eth0');/g" config.php
sed -i "s/\$language = 'nl';/\$language = 'en';/g" config.php
sed -i 's/Internal/Internet/g' config.php
sed -i '/SixXS IPv6/d' config.php
sed -i "s/\$locale = 'en_US.UTF-8';/\$locale = 'en_US.UTF+8';/g" config.php
cd
clear
# Install BadVPN
apt-get -y install cmake make gcc
wget https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/badvpn-1.999.127.tar.bz2
tar xf badvpn-1.999.127.tar.bz2
mkdir badvpn-build
cd badvpn-build
cmake ~/badvpn-1.999.127 -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1
make install
screen badvpn-udpgw --listen-addr 127.0.0.1:7300 > /dev/null &
cd

# download script
cd
wget -O /usr/bin/benchmark "https://raw.githubusercontent.com/macisvpn/premiumnow/master/menu/benchmark.sh"
wget -O /usr/bin/speedtest  "https://raw.githubusercontent.com/macisvpn/premiumnow/master/menu/speedtest_cli.py"
wget -O /usr/bin/ps-mem "https://raw.githubusercontent.com/macisvpn/premiumnow/master/menu/ps_mem.py"
wget -O /usr/bin/dropmon "https://raw.githubusercontent.com/macisvpn/premiumnow/master/menu/dropmon.sh"
wget -O /usr/bin/menu "https://raw.githubusercontent.com/macisvpn/premiumnow/master/menu/menu"
wget -O /usr/bin/user-active-list "https://raw.githubusercontent.com/macisvpn/premiumnow/master/menu/user-active-list.sh"
wget -O /usr/bin/user-add "https://raw.githubusercontent.com/macisvpn/premiumnow/master/menu/user-add.sh"
wget -O /usr/bin/user-add-pptp "https://raw.githubusercontent.com/macisvpn/premiumnow/master/menu/user-add-pptp.sh"
wget -O /usr/bin/user-del "https://raw.githubusercontent.com/macisvpn/premiumnow/master/menu/user-del.sh"
wget -O /usr/bin/disable-user-expire "https://raw.githubusercontent.com/macisvpn/premiumnow/master/menu/disable-user-expire.sh"
wget -O /usr/bin/delete-user-expire "https://raw.githubusercontent.com/macisvpn/premiumnow/master/menu/delete-user-expire.sh"
wget -O /usr/bin/banned-user "https://raw.githubusercontent.com/macisvpn/premiumnow/master/menu/banned-user.sh"
wget -O /usr/bin/unbanned-user "https://raw.githubusercontent.com/macisvpn/premiumnow/master/menu/unbanned-user.sh"
wget -O /usr/bin/user-expire-list "https://raw.githubusercontent.com/macisvpn/premiumnow/master/menu/user-expire-list.sh"
wget -O /usr/bin/user-gen "https://raw.githubusercontent.com/macisvpn/premiumnow/master/menu/user-gen.sh"
wget -O /usr/bin/userlimit.sh "https://raw.githubusercontent.com/macisvpn/premiumnow/master/menu/userlimit.sh"
wget -O /usr/bin/userlimitssh.sh "https://raw.githubusercontent.com/macisvpn/premiumnow/master/menu/userlimitssh.sh"
wget -O /usr/bin/user-list "https://raw.githubusercontent.com/macisvpn/premiumnow/master/menu/user-list.sh"
wget -O /usr/bin/user-login "https://raw.githubusercontent.com/macisvpn/premiumnow/master/menu/user-login.sh"
wget -O /usr/bin/user-pass "https://raw.githubusercontent.com/macisvpn/premiumnow/master/menu/user-pass.sh"
wget -O /usr/bin/user-renew "https://raw.githubusercontent.com/macisvpn/premiumnow/master/menu/user-renew.sh"
wget -O /usr/bin/clearcache.sh "https://raw.githubusercontent.com/macisvpn/premiumnow/master/menu/clearcache.sh"
wget -O /usr/bin/bannermenu "https://raw.githubusercontent.com/macisvpn/premiumnow/master/menu/bannermenu"
cd

#rm -rf /etc/cron.weekly/
#rm -rf /etc/cron.hourly/
#rm -rf /etc/cron.monthly/
rm -rf /etc/cron.daily/
wget -O /root/passwd "https://raw.githubusercontent.com/macisvpn/premiumnow/master/menu/passwd.sh"
chmod +x /root/passwd
echo "01 23 * * * root /root/passwd" > /etc/cron.d/passwd

echo "*/30 * * * * root service dropbear restart" > /etc/cron.d/dropbear
echo "00 23 * * * root /usr/bin/disable-user-expire" > /etc/cron.d/disable-user-expire
echo "0 */12 * * * root /sbin/reboot" > /etc/cron.d/reboot
#echo "00 01 * * * root echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a" > /etc/cron.d/clearcacheram3swap
echo "*/30 * * * * root /usr/bin/clearcache.sh" > /etc/cron.d/clearcache1

cd
chmod +x /usr/bin/benchmark
chmod +x /usr/bin/speedtest
chmod +x /usr/bin/ps-mem
#chmod +x /usr/bin/autokill
chmod +x /usr/bin/dropmon
chmod +x /usr/bin/menu
chmod +x /usr/bin/user-active-list
chmod +x /usr/bin/user-add
chmod +x /usr/bin/user-add-pptp
chmod +x /usr/bin/user-del
chmod +x /usr/bin/disable-user-expire
chmod +x /usr/bin/delete-user-expire
chmod +x /usr/bin/banned-user
chmod +x /usr/bin/unbanned-user
chmod +x /usr/bin/user-expire-list
chmod +x /usr/bin/user-gen
chmod +x /usr/bin/userlimit.sh
chmod +x /usr/bin/userlimitssh.sh
chmod +x /usr/bin/user-list
chmod +x /usr/bin/user-login
chmod +x /usr/bin/user-pass
chmod +x /usr/bin/user-renew
chmod +x /usr/bin/clearcache.sh
chmod +x /usr/bin/bannermenu
cd

clear
# restart service
service ssh restart
service openvpn restart
service dropbear restart
service webmin restart
service squid restart
service fail2ban restart
clear
# SELASAI SUDAH BOSS! ( AutoScriptNobita.Tk )
echo "========================================"  | tee -a log-install.txt
echo "Service Autoscript inject69 (NOBITA inject69 2017)"  | tee -a log-install.txt
echo "----------------------------------------"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "nginx : http://$myip:80"   | tee -a log-install.txt
echo "Webmin : http://$myip:10000/"  | tee -a log-install.txt
echo "Squid3 : 8080"  | tee -a log-install.txt
echo "OpenSSH : 22"  | tee -a log-install.txt
echo "Dropbear : 443"  | tee -a log-install.txt
echo "OpenVPN  : TCP 1194 (DAPATKAN OVPN DARI SAYA)"  | tee -a log-install.txt
echo "Fail2Ban : [on]"  | tee -a log-install.txt
echo "Timezone : Asia/Kuala_Lumpur"  | tee -a log-install.txt
echo "Menu : type menu to check menu script"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "----------------------------------------"
echo "LOG INSTALL  --> /root/log-install.txt"
echo "----------------------------------------"
echo "========================================"  | tee -a log-install.txt
echo "      PLEASE REBOOT TO TAKE EFFECT !"
echo "========================================"  | tee -a log-install.txt
cat /dev/null > ~/.bash_history && history -c
