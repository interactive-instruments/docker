FROM stackbrew/ubuntu:14.04
MAINTAINER J Herrmann <herrmann@interactive-instruments.de>

# Set the UTF-8 Locale
####################################################
RUN locale-gen de_DE.UTF-8 
RUN locale-gen en_US.UTF-8 
RUN update-locale LANG=de_DE.UTF-8
####################################################


# Install unzip and wget
####################################################
RUN echo 'APT::Install-Recommends 0;' >> /etc/apt/apt.conf.d/01norecommends \
 && echo 'APT::Install-Suggests 0;' >> /etc/apt/apt.conf.d/01norecommends \
 && apt-get update \
 && apt-get install -q -y --no-install-recommends \
		unzip \
		wget \
		net-tools \
		ca-certificates \
 && rm -rf /var/lib/apt/lists/*
