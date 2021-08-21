FROM node:current-buster

RUN apt-get update

#  This is here bc I was getting the following upon `lamdera init`: error while loading shared libraries: libtinfo.so.5: cannot open shared object file: No such file or directory          
RUN apt install -y \
    libtinfo5 

# Install lamdera refer to: https://dashboard.lamdera.app/docs/download
RUN curl https://static.lamdera.com/bin/linux/lamdera -o /usr/local/bin/lamdera
RUN chmod a+x /usr/local/bin/lamdera
