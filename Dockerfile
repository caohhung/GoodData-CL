FROM docker-registry-el7.na.intgdc.com/gdc_base_co7:latest

LABEL name="CL-Tool executable image based on CentOS-7" \
      maintainer="Silent Assassins Scrum <scrumsa@gooddata.com>" \
      vendor="CentOS" \
      license="GPLv2"
ADD artifact /cl-tool
WORKDIR /cl-tool

