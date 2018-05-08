##############################
# Edward Centos 7 Base
# Tag: edwardkan/fileserver
#
# Refer:
# http://stackoverflow.com/questions/31644391/docker-centos-7-cron-not-working-in-local-machine
#
# Run:
# docker run --rm -it -h fileserver --name fileserver -v /mnt/dockerData/fileserver:/mnt/remoteStorage -p 1023:22 -p 445:445 -p 139:139 -p 135:135 -p 137:137/udp -p 138:138/udp -d edwardkan/docker-fileserver
# 
# Build:
# docker build -t edwardkan/fileserver .
#
# Dependancy:
# Centos 7
# DOCKERIZE_VERSION v0.2.0
#
# Permission:
# etc drwxr-xr-x (755)
# root dr-xr-x--- (550)
##############################

FROM edwardkan/docker-centos7:latest
MAINTAINER Edward Kan <kan.edward@gmail.com>

# Add Files
#ADD container-files / 
# ssh key contain in root folder
ADD container-files/etc /etc 
ADD container-files/config /config 


RUN \
    yum -y install \
        samba samba-client samba-common \
        rsync \


RUN \ 
    # create backup of origal smb.conf
    cp /etc/samba/smb.conf /etc/samba/smb.conf.bak && \


# Clean YUM caches to minimise Docker image size
RUN yum clean all && rm -rf /tmp/yum*

# Remove pass file
#RUN rm -f /root/root.txt 

# EXPOSE
# smb 
expose 445
expose 139
expose 135

# nmb
expose 137/udp
expose 138/udp


# Run supervisord as demon with option -n 
#CMD dockerize /config/run.sh
#CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]

