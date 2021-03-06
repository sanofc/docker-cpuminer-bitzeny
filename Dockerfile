FROM ubuntu:16.04

RUN apt-get update -y \
 && apt-get install -y git automake build-essential libcurl4-openssl-dev

RUN git clone https://github.com/bitzeny/cpuminer.git

WORKDIR cpuminer

RUN ./autogen.sh \
 && ./configure CFLAGS="-O3 -march=native -funroll-loops -fomit-frame-pointer" \
 && make \
 && make install

CMD minerd -a yescrypt -o stratum+tcp://$POOL_URL:$POOL_PORT -u $USER -p $PASSWORD