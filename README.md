[![Build Status](https://travis-ci.org/BorderCloud/tft-jena-fuseki.svg)](https://travis-ci.org/BorderCloud/tft-jena-fuseki)

# tft-jena-fuseki : Jena Fuseki 3.4.0



## Calculate Sparql Score with TFT

### Install TFT context
```
docker pull bordercloud/tft-virtuoso7-stable
docker build -t tft-jena-fuseki .
docker run --privileged --name instance.tft_database -d tft-jena-fuseki
docker run --privileged --name instance.tft.example.org -h example.org -d bordercloud/tft-virtuoso7-stable
docker run --privileged --name instance.tft.example1.org -h example1.org -d bordercloud/tft-virtuoso7-stable
docker run --privileged --name instance.tft.example2.org -h example2.org -d bordercloud/tft-virtuoso7-stable
docker run --privileged --name instance.jena-fuseki -h tft-jena-fuseki -d tft-jena-fuseki
#rm -rf TFT
git clone --recursive https://github.com/BorderCloud/TFT.git
cd TFT
composer install --dev
```

### Start tests
Add parameter debug if necessary '-d'
```
php ./tft-testsuite -a -t fuseki -q http://172.17.0.2/test/query -u http://172.17.0.2/test/update
php ./tft -t fuseki -q http://172.17.0.2/test/query -u http://172.17.0.2/test/update -tt fuseki -tq http://172.17.0.6/test/query -tu http://172.17.0.6/test/update -r https://github.com/BorderCloud/TFT/jena-fuseki/v3.4.0 -o ./junit --softwareName="Jena Fuseki"  --softwareDescribeTag=v3.4.0
php ./tft-score -t fuseki -q http://172.17.0.2/test/query -u http://172.17.0.2/test/update -r  https://github.com/BorderCloud/TFT/jena-fuseki/v3.4.0
```


# Reproduce without build

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker pull bordercloud/tft-virtuoso7-stable
docker pull -t bordercloud/tft-jena-fuseki
docker run --privileged --name instance.tft_database -d bordercloud/tft-jena-fuseki
docker run --privileged --name instance.tft.example.org -h example.org -d bordercloud/tft-virtuoso7-stable
docker run --privileged --name instance.tft.example1.org -h example1.org -d bordercloud/tft-virtuoso7-stable
docker run --privileged --name instance.tft.example2.org -h example2.org -d bordercloud/tft-virtuoso7-stable
docker run --privileged --name instance.jena-fuseki -h tft-jena-fuseki -d bordercloud/tft-jena-fuseki
git clone --recursive https://github.com/BorderCloud/TFT.git
cd TFT
composer install --dev
php ./tft-testsuite -a -t fuseki -q http://172.17.0.2/test/query -u http://172.17.0.2/test/update
php ./tft -t fuseki -q http://172.17.0.2/test/query -u http://172.17.0.2/test/update -tt fuseki -tq http://172.17.0.6/test/query -tu http://172.17.0.6/test/update -r http://test.example.com -o ./junit --softwareName="Fuseki"  --softwareDescribeTag=v3.4.0
php ./tft-score -t fuseki -q http://172.17.0.2/test/query -u http://172.17.0.2/test/update -r  http://test.example.com


