FROM rocker/rstudio:3.6.3

ENV USER=rstudio
ENV PASSWORD=qwerty

VOLUME [ "/home" ]

EXPOSE 8787:8787

CMD ["R"]