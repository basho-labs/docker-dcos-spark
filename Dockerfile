FROM mesosphere/mesos:0.23.0-1.0.ubuntu1404
MAINTAINER Jon Brisbin <jbrisbin@basho.com>

# Use Mesos already installed in this image
ENV MESOS_NATIVE_JAVA_LIBRARY /usr/lib/libmesos.so

# Set up APT to pull backports (for 'jq')
ENV DEBIAN_FRONTEND "noninteractive"
ENV DEBCONF_NONINTERACTIVE_SEEN "true"
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN apt-get update

# Install some utilities
RUN apt-get install -y git curl wget jq

# Install DCOS
RUN apt-get install -y python-dev libffi-dev libssl-dev python-virtualenv python-pip
WORKDIR /opt
RUN git clone https://github.com/mesosphere/dcos-cli.git && cd dcos-cli && make env && make packages && cd cli && make env
ADD install_dcos_pkgs.sh /
RUN /install_dcos_pkgs.sh

# Install Spark
#RUN curl -O http://d3kbcqa49mib13.cloudfront.net/spark-1.5.2-bin-hadoop2.6.tgz
#RUN tar -zxvf spark-1.5.2-bin-hadoop2.6.tgz -C /opt
# (uncomment if using an already-downloaded tarball and comment out the above two lines)
ADD spark-1.5.2-bin-hadoop2.6.tgz /opt
ENV SPARK_HOME /opt/spark-1.5.2-bin-hadoop2.6
ENV PATH $SPARK_HOME/bin:$PATH

COPY bashrc /root/.bashrc
WORKDIR /root
ENTRYPOINT /bin/bash -i -l
