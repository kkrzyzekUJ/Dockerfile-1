#
# Scala+sbt+Play Framework Dockerfile
#
FROM debian:9.3
LABEL maintainer="KKrzyzek, krzyzek.krzysztof@gmail.com"

RUN apt-get update
RUN apt-get install apt-transport-https gnupg -y

RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN apt-get update

#Install mysql
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server

#Java License
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

#Install sbt
RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
RUN apt-get update
RUN apt-get install -y sbt

#Install java8 + scala
RUN apt-get install -y oracle-java8-installer
RUN apt-get install oracle-java8-set-default
RUN apt-get install -y scala sbt

#Port exposed
EXPOSE 9000

#Get Playframework
WORKDIR /home/
RUN git clone https://github.com/playframework/play-scala-slick-example
WORKDIR /home/play-scala-slick-example

#Check if success
RUN java -version
RUN scala -version || true

CMD sbt run


