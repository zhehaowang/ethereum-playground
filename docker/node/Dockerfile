FROM ubuntu:xenial

MAINTAINER Zhehao

RUN apt-get update \
     && apt-get install -y wget \
     && rm -rf /var/lib/apt/lists/* 

WORKDIR "/opt"
ARG BINARY="geth-alltools-linux-amd64-1.8.1-1e67410e.tar.gz"
RUN wget "https://gethstore.blob.core.windows.net/builds/$BINARY"
RUN tar -xzvf $BINARY --strip 1
RUN rm $BINARY

ADD ./genesis.json ./genesis.json
RUN ./geth init genesis.json

ARG password
ARG privatekey
RUN echo $password > ~/.accountpassword
RUN echo $privatekey > ~/.privatekey
RUN ./geth account import --password ~/.accountpassword  ~/.privatekey

ENV address=""
ENV bootnodeId=""
ENV bootnodeIp=""
CMD exec ./geth --bootnodes "enode://$bootnodeId@$bootnodeIp:30301" --networkid="500" --verbosity=3 --rpc --rpcaddr "0.0.0.0" --rpccorsdomain "*" --mine --etherbase $address --unlock $address --password ~/.accountpassword --rpcapi="db,eth,net,web3,personal,miner,clique"

EXPOSE 8545
EXPOSE 30303
