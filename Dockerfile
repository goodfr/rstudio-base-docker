FROM rocker/rstudio:3.6.2

ENV USER=rstudio
ENV PASSWORD=qwerty

VOLUME [ "/home" ]

EXPOSE 8787