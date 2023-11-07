FROM ubuntu:22.04

# Dependencies to build RiscV CPU:
# https://github.com/SpinalHDL/VexRiscv

# JAVA JDK 8
RUN apt-get update -y && \
    apt-get install -y software-properties-common gpg-agent --no-install-recommends && \
    add-apt-repository ppa:openjdk-r/ppa && \
    apt-get update -y && \
    apt-get install -y openjdk-8-jdk && \
    update-alternatives --config java && \
    update-alternatives --config javac

# Install SBT - https://www.scala-sbt.org/
RUN apt-get update -y && apt-get install -y curl --no-install-recommends && \
    echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | tee /etc/apt/sources.list.d/sbt.list && \
    echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | tee /etc/apt/sources.list.d/sbt_old.list && \
    curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | apt-key add && \
    apt-get update -y && \
    apt-get install -y sbt --no-install-recommends

## Verilator (for sim only, really needs 3.9+, in general apt-get will give you 3.8)
RUN apt-get install -y git make autoconf g++ flex bison flex libfl2 libfl-dev --no-install-recommends && \
    git clone http://git.veripool.org/git/verilator && \
    unset VERILATOR_ROOT  && \
    cd verilator && \
    git pull && \
    git checkout v4.216 && \
    autoconf && \
    ./configure && \
    make && \
    make install

