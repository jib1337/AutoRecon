FROM kalilinux/kali-rolling

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/autorecon
RUN mkdir /autorecon
RUN mkdir /autorecon/config
RUN mkdir /autorecon/helpers
RUN mkdir /autorecon/results

ADD autorecon /autorecon
ADD cherrycon.py /autorecon
ADD config/ /autorecon/config/
ADD requirements.txt /autorecon

RUN sed -i "s/\/home\/{getuser()}\/Desktop/\/autorecon\/results/g" /autorecon/autorecon

RUN apt update
RUN apt install -y wget libffi-dev gcc build-essential curl tcl-dev tk-dev uuid-dev liblzma-dev libssl-dev libsqlite3-dev
RUN wget https://www.python.org/ftp/python/3.10.0/Python-3.10.0.tgz
RUN tar -zxvf Python-3.10.0.tgz
RUN cd Python-3.10.0 && ./configure --prefix=/opt/python3.10 && make && make install
RUN rm Python-3.10.0.tgz
RUN rm -r Python-3.10.0/
RUN ln -s /opt/python3.10/bin/python3.10 /usr/bin/python

RUN apt install sudo git -y \
    && apt install seclists curl enum4linux gobuster dirb nbtscan nikto \
                   nmap onesixtyone oscanner smbclient smbmap smtp-user-enum \
                   snmp sslscan sipvicious whatweb exploitdb \
                   nfs-common vim iputils-ping net-tools wget wpscan -y \
    && apt clean

RUN python -m pip install -r /autorecon/requirements.txt

RUN git clone https://gitlab.com/saalen/ansifilter && cd ansifilter && make && make install

ENTRYPOINT ["autorecon"]
