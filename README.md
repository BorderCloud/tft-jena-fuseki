[![Build Status](https://travis-ci.org/BorderCloud/tft-jena-fuseki.svg)](https://travis-ci.org/BorderCloud/tft-jena-fuseki)

# tft-jena-fuseki : Jena Fuseki

## Calculate SparqlScore with TFT in local

### Install
```
# Download docker's images 
docker pull bordercloud/tft-virtuoso7-stable
#docker pull bordercloud/tft-jena-fuseki

# Compile the docker's project 
docker build -t tft-jena-fuseki .
  
# Deploy network of SPARQL services

docker-compose up -d 
# docker-compose stop

git clone --recursive https://github.com/BorderCloud/TFT.git
cd TFT

# install SPARQL client
composer install 

# install JMeter for protocol tests
wget http://mirrors.standaloneinstaller.com/apache//jmeter/binaries/apache-jmeter-5.4.1.tgz
tar xvzf apache-jmeter-5.4.1.tgz 
mv  apache-jmeter-5.4.1 jmeter
rm apache-jmeter-5.4.1.tgz 
```

### Start tests
Add parameter debug if necessary '-d'
```
php ./tft-testsuite -a -t fuseki -q http://172.30.0.6:8080/test/query \
                    -u http://172.30.0.6:8080/test/update
          
php ./tft -t fuseki -q http://172.30.0.6:8080/test/query \
                    -u http://172.30.0.6:8080/test/update \
          -tt fuseki -te http://172.30.0.2/sparql \
          -r http://example.org/buildid   \
          -o ./junit  \
          --softwareName="Jena" \
          --softwareDescribeTag=X.X.X \
          --softwareDescribe="Name" -d
                    
php ./tft-score -t fuseki -q http://172.30.0.6:8080/test/query \
                          -u http://172.30.0.6:8080/test/update \
                -r  http://example.org/buildid
```


# Delete all containers

```
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
```

# Check the network
```
docker network list
docker network inspect tft-jena-fuseki_tft
```
The result has to be :
* instance.tft-jena-fuseki" => 172.30.0.2
* instance.tft.example.org =>  172.30.0.3
* instance.tft.example1.org => 172.30.0.4
* instance.tft.example2.org => 172.30.0.5
* instance.tft-database =>     172.30.0.6

# Open bash in container
```
docker exec -it instance.tft-jena-fuseki bash
docker exec -it instance.tft-database bash
```

#Realign SPARQL API with Varnish

## Install Varnish 6 and modules
```
yum install python-docutils automake autoconf libtool ncurses-devel libxslt groff pcre-devel pkgconfig

wget https://packagecloud.io/install/repositories/varnishcache/varnish60/script.rpm.sh
chmod +x ./script.rpm.sh
./script.rpm.sh
yum install varnish varnish-devel

git clone https://github.com/varnish/varnish-modules.git
cd varnish-modules
./bootstrap  
./configure
make
make install
```

## Check test
```
varnishtest rewriting.vtc
```

## Test on server
```
#varnishd -C -f /etc/varnish/default.vcl
vi /etc/varnish/default.vcl
systemctl start varnish
systemctl enable varnish

```

# Logs
```
journalctl -f -u jena
journalctl -f -u varnish
```
