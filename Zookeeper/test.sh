docker run -d --net=host --name=zookeeper -e SERVICES_ZOOKEEPER_MYID=1 -e SERVICES_ZOOKEEPER_HOST_1='{"Id" : "1", "Ip" : "<ip>"}' rapture/zookeeper
