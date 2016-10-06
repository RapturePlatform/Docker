FROM ubuntu:14.04

# Import MongoDB public GPG key AND create a MongoDB list file
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
ENV MONGO_MAJOR 3.2
ENV MONGO_VERSION 3.2.4

RUN echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/$MONGO_MAJOR main" > /etc/apt/sources.list.d/mongodb-org.list

RUN set -x \
	&& apt-get update \
	&& apt-get install -y --force-yes \
		mongodb-org=$MONGO_VERSION \
		mongodb-org-server=$MONGO_VERSION \
		mongodb-org-shell=$MONGO_VERSION \
		mongodb-org-mongos=$MONGO_VERSION \
		mongodb-org-tools=$MONGO_VERSION


#install oracle java 8
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN apt-get install oracle-java8-installer -y
RUN apt-get install oracle-java8-set-default

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Link the MongoDB data directory
RUN mkdir -p /data/db
COPY mongod.conf /etc/mongod.conf
VOLUME ["/data/db"]

# Expose port 27017 from the container to the host
EXPOSE 27017 28017

ADD run.sh /run.sh
ADD set_mongodb_password.sh /set_mongodb_password.sh
RUN chmod +x /run.sh
RUN chmod +x /set_mongodb_password.sh

CMD ["/run.sh"]

LABEL Description="Launches mongo; also has jdk 1.8 installed"
LABEL Usage="docker run -d -p 27017:27017 --name mongo rapture/mongo"
LABEL Usage-performance="docker run -d -p 27017:27017  --name mongo rapture/mongo"
LABEL Build-instructions="docker build -t rapture/mongo ."
