FROM debian:jessie

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y \
    && DEBIAN_FRONTEND=noninteractive apt-get -yy -q \
    install \
    iptables \
    ca-certificates \
    file \
    util-linux \
    socat \
    wget \
    && DEBIAN_FRONTEND=noninteractive apt-get autoremove -y \
    && DEBIAN_FRONTEND=noninteractive apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
RUN cp /usr/bin/nsenter /nsenter

ARG VERSION

RUN wget https://github.com/kubernetes/kubernetes/releases/download/${VERSION}/kubernetes.tar.gz && \
    tar xzf kubernetes.tar.gz && \
    tar xzf kubernetes/server/kubernetes-server-linux-amd64.tar.gz kubernetes/server/bin/hyperkube && \
    cp kubernetes/server/bin/hyperkube /hyperkube && \
    mkdir -p /etc/kubernetes/manifests-multi && \
    mkdir -p /etc/kubernetes/manifests && \
    cp kubernetes/cluster/images/hyperkube/master.json /etc/kubernetes/manifests/master.json && \
    cp kubernetes/cluster/images/hyperkube/master-multi.json /etc/kubernetes/manifests-multi/master.json && \
    rm -rf kubernetes*
  
CMD ["/hyperkube", "--help"]
