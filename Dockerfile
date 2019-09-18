FROM fedora

LABEL maintaiter="Jakub Filak <jakub.filak@sap.com>"

RUN dnf install -y tar npm python3 python3-requests python3-pyOpenSSL curl

RUN curl -kL https://github.com/jfilak/sapcli/archive/master.tar.gz | tar -C /opt/ -zx

RUN ln -sf /opt/sapcli-master/sap /usr/lib/python3.7/site-packages/
RUN ln -sf /opt/sapcli-master/bin/sapcli /bin/sapcli

RUN sapcli --help

RUN curl -kL https://github.com/larshp/abapmerge/archive/master.tar.gz | tar -C /opt/ -zx
RUN cd /opt/abapmerge-master && npm install && npm test
RUN ln -sf /opt/abapmerge-master/abapmerge /bin/abapmerge

USER sapper
