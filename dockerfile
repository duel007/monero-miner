FROM ubuntu:latest
MAINTAINER Matt Ware <mattj.ware@gmail.com>

USER root

ENV WALLET 43Vjt9JgZS8gJYmx91LdoQNTZrahD99dbeZDjaAijHCShdWTfhmN1at66W5QgSLfrzUxracRiijk4ERZbTPEEAZ17ULcQiV 
ENV POOL stratum+tcp://mine.moneropool.com:3333

RUN apt-get update -qq
RUN apt-get install -qqy libcurl4-openssl-dev git make automake

RUN git clone https://github.com/wolf9466/cpuminer-multi /cpuminer-multi

RUN cd /cpuminer-multi; ./autogen.sh; ./configure; make

ENTRYPOINT sudo nice -n -10 /cpuminer-multi/minerd -a cryptonight -o $POOL -u $WALLET -p x

# docker run -dit --name=monero --net=host --pid=host duel007/monero-miner
