FROM kalilinux/kali

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/autorecon
RUN mkdir /autorecon
RUN mkdir /autorecon/config
RUN mkdir /autorecon/helpers
RUN mkdir /autorecon/results

ADD autorecon /autorecon
ADD cherrycon.py /autorecon
ADD config/ /autorecon/config/
ADD helpers/ /autorecon/helpers/
ADD requirements.txt /autorecon

RUN sed -i "s/\/home\/{getuser()}\/Desktop/\/autorecon\/results/g" /autorecon/autorecon

RUN apt update \
    && apt install sudo git -y \
    && apt install python3 -y \
    && apt install python3-pip -y \
    && apt install seclists curl enum4linux gobuster dirb nbtscan nikto \
                   nmap onesixtyone oscanner smbclient smbmap smtp-user-enum \
                   snmp sslscan sipvicious whatweb exploitdb \
                   nfs-common vim iputils-ping net-tools wget wpscan -y \
    && apt clean \
    && python3 -m pip install -r /autorecon/requirements.txt

RUN git clone https://gitlab.com/saalen/ansifilter && cd ansifilter && make && make install

ENTRYPOINT ["autorecon"]
