docker run -d --name=zookeeper -e SERVICES_ZOOKEEPER_MYID=1 -e SERVICES_ZOOKEEPER_HOST_1='{"Id" : "1", "Ip" : "<ip>"}' --name zookeeper -p 2181:2181 rapture/zookeeper

docker run -d -v /var/run/docker.sock:/var/run/docker.sock -p 9092:9092 -e KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181 --link zookeeper --name kafka -t rapture/kafka
