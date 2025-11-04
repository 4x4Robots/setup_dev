# Use latest LTS Ubuntu version
FROM ubuntu:noble
# Set env debian_frontend for less error messages
ENV DEBIAN_FRONTEND noninteractive
# Install the unminimize package
RUN apt-get update && apt-get install -y unminimize
# Run the unminimize command to provide all standard packages
# See https://hub.docker.com/_/ubuntu for more information
RUN yes | unminimize
# Install sudo command
RUN apt-get update && apt-get install -y sudo
# Install Ubuntu server essentials
RUN apt install ubuntu-server -y && apt clean
# Upgrade all packages
RUN apt-get update && apt-get upgrade -y && apt-get autoremove
