FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive

ENV JAVA_URL=http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.tar.gz


RUN \ 
apt update -y && \
apt upgrade -y && \
apt install wget -y && \
apt install tesseract-ocr tesseract-ocr-eng -y && \
apt install clamav -y && \
apt install imagemagick -y && \
apt install ghostscript -y && \
apt install mysql-server -y && \
apt install unzip -y && \
cd /tmp/ && \
wget http://www.ftp.ne.jp/office/tdf/libreoffice/stable/6.1.2/deb/x86_64/LibreOffice_6.1.2_Linux_x86-64_deb.tar.gz &&\
tar xvf /tmp/LibreOffice_6.1.2_Linux_x86-64_deb.tar.gz && \
cd /tmp/LibreOffice_6.1.2.1_Linux_x86-64_deb/DEBS/ && \
dpkg -i *.deb && \
rm -rf /tmp/LibreOffice_6.1.2.1_Linux_x86-64_deb && \
rm -f /tmp/LibreOffice_6.1.2_Linux_x86-64_deb.tar.gz

#Install java
RUN \
cd /tmp/ && \
wget --quiet --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" ${JAVA_URL} && \
tar xvf jdk* && \
mv jdk* /usr/local && \
ln -s /usr/local/jdk*/bin/java /usr/bin/java && \
rm -f /tmp/jdk*

RUN \
groupadd openkm && \
useradd -d /home/openkm -c "OpenKM User" -g openkm -m -s /bin/bash -p Webl0g1c openkm


RUN \
echo "*   soft  nofile   6084" >>  /etc/security/limits.conf && \
echo "*   hard  nofile   6084" >> /etc/security/limits.conf

# Run MySQL
RUN \
/etc/init.d/mysql start && \
mysql -h localhost -u root -p"Webl0g1c" -e "CREATE DATABASE okmdb DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_bin" && \
mysql -h localhost -u root -p"Webl0g1c" -e "CREATE USER openkm@localhost IDENTIFIED BY 'Medicare01'" && \
mysql -h localhost -u root -p"Webl0g1c" -e "GRANT ALL ON okmdb.* TO openkm@localhost WITH GRANT OPTION"
#
# Install Tomcat bundle
RUN \
cd /home/openkm && \
wget -O Tomcat-8.5.24.zip https://sourceforge.net/projects/openkm/files/common/Tomcat-8.5.24.zip/download && \
wget -O OpenKM.war.zip https://sourceforge.net/projects/openkm/files/6.3.6/OpenKM-6.3.6.zip/download && \
unzip Tomcat-8.5.24.zip && \
unzip OpenKM.war.zip && \
rm -f /home/openkm/Tomcat-8.5.24.zip && \
cp /home/openkm/OpenKM.war /home/openkm/tomcat-8.5.24/webapps/ && \
rm -f /home/openkm/OpenKM.war && \
rm -f /home/openkm/tomcat-8.5.24/conf/server.xml && \
rm -f /home/openkm/tomcat-8.5.24/OpenKM.cfg

COPY tomcat /etc/init.d/

COPY server.xml /home/openkm/tomcat-8.5.24/conf/ 
COPY OpenKM.cfg /home/openkm/tomcat-8.5.24/

RUN \
chown -R openkm.openkm /home/openkm/

COPY start.sh /

ENTRYPOINT [ "/start.sh" ]









