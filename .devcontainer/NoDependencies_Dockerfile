# Use latest LTS Ubuntu version
FROM ubuntu:noble
# Set env debian_frontend for less error messages
#ENV DEBIAN_FRONTEND noninteractive
# Install the unminimize package
RUN apt-get update && apt-get install -y unminimize
# Run the unminimize command to provide all standard packages
# See https://hub.docker.com/_/ubuntu for more information
RUN yes | unminimize
# Install sudo command
RUN apt-get update && apt-get install -y sudo
# Install Ubuntu server essentials
#RUN apt install ubuntu-server -y && apt clean
# Install XFCE desktop
# https://raspberrytips.com/best-desktop-environments-ubuntu/
RUN apt-get install xfce4 gdm3
# Install XRDP (remote desktop protocol)
# https://medium.com/cloud-for-all/running-ubuntu-os-with-gui-in-a-docker-container-rdp-dbecb0880893
#RUN apt install -y xrdp && \
#    adduser xrdp ssl-cert
# Upgrade all packages
RUN apt-get update && apt-get upgrade -y && apt-get autoremove
