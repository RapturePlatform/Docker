FROM ubuntu:14.04
MAINTAINER ukmoore

ENV CASSANDRA_VERSION 3.7.0

RUN echo "deb http://debian.datastax.com/datastax-ddc 3.7 main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
RUN sudo apt-get update
RUN apt-get install -y curl
RUN curl -L http://debian.datastax.com/debian/repo_key | sudo apt-key add -
RUN apt-get install unzip


#install oracle java 8
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:webupd8team/java -y
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN apt-get update
RUN sudo apt-get install oracle-java8-installer -y
RUN sudo apt-get install oracle-java8-set-default

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle


RUN apt-get update && sudo apt-get -y install datastax-ddc \
		&& rm -rf /var/lib/apt/lists/*


ENV CASSANDRA_CONFIG /etc/cassandra

# listen to all rpc
RUN sed -ri ' \
		s/^(rpc_address:).*/\1 0.0.0.0/; \
		' "$CASSANDRA_CONFIG/cassandra.yaml" \
		&& sed -ri ' \
			s/^(start_rpc:).*/\1 true/; \
		' "$CASSANDRA_CONFIG/cassandra.yaml"

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN useradd -ms /bin/bash cassie
RUN sudo chown -R cassie: /etc/cassandra/ \
		&& sudo chown -R cassie: /var/lib/cassandra/ \
		&& sudo chown -R cassie: /var/log/cassandra/
USER cassie

ENTRYPOINT ["/docker-entrypoint.sh"]

VOLUME /var/lib/cassandra

# 7000: intra-node communication
# 7001: TLS intra-node communication
# 9042: CQL
# 9160: thrift service
EXPOSE 7000 7001 9042 9160

CMD ["cassandra", "-f"]

LABEL Description="Launches Cassandra; also has jdk 1.8 installed"
LABEL Usage="docker run -d -p 9160:9160 --name cassandra rapture/cassandra"
LABEL Usage-performance="docker run -d -p 9160:9160 --name cassandra rapture/cassandra"
LABEL Build-instructions="docker build -t rapture/cassandra ."
