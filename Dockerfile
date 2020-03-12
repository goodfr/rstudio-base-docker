FROM rocker/rstudio:3.6.2

ENV USER=rstudio
ENV PASSWORD=qwerty

USER root

# VOLUME [ "/home" ]
# EXPOSE 8787

# Install Impala ODBC dependency
# RUN cd /tmp && \
#     wget --no-verbose https://downloads.cloudera.com/connectors/impala_odbc_2.5.41.1029/Debian/clouderaimpalaodbc_2.5.41.1029-2_amd64.deb && \
#     dpkg -i clouderaimpalaodbc_2.5.41.1029-2_amd64.deb && \
#     odbcinst -i -d -f /opt/cloudera/impalaodbc/Setup/odbcinst.ini

RUN mkdir /root/.R/
RUN echo CXXFLAGS=-DBOOST_PHOENIX_NO_VARIADIC_EXPRESSION > /root/.R/Makevars

# Be sure rstudio user has full access to his home directory
RUN mkdir -p /home/rstudio && \
  chown -R rstudio:rstudio /home/rstudio && \
  chmod -R 755 /home/rstudio

ADD ./init_rstudio.sh /
RUN chmod 500 /init_rstudio.sh

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq && apt-get install -yqq --no-install-recommends \
      krb5-user && \
    rm -rf /var/lib/apt/lists/*;

# Store Root envvar to be able to exclude it at runtime when propagating envvars to every user
RUN env >> /ROOT_ENV_VAR && chmod 400 /ROOT_ENV_VAR

CMD ["/bin/sh", "-c", "/init_rstudio.sh"]