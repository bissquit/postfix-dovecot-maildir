FROM debian:latest
MAINTAINER E.Vasilyev <bq@bissquit.ru>

ENV DomainName bissquit.ru
ENV UserName bissquit

# preinstallation tasks
RUN echo mail > /etc/hostname

RUN echo "127.0.0.1 localhost mail mail.${DomainName}" > /etc/hosts \
  $$ chown root:root /etc/hosts

# installation
RUN echo "postfix postfix/main_mailer_type string Internet site" > postfix_silent_install.txt \
 $$ echo "postfix postfix/mailname string mail.${DomainName}" >> postfix_silent_install.txt \
 $$ debconf-set-selections postfix_silent_install.txt

RUN apt-get update $$ DEBIAN_FRONTEND=noninteractive apt-get install -q -y \
  postfix \
  dovecot-common \
  dovecot-imapd \
  dovecot-pop3d \
  nano \
  rsyslog

# create account
RUN useradd -m -d /home/${UserName} -s /bin/false ${UserName} \
 $$ echo "root: ${UserName}" >> /etc/aliases \
 $$ newaliases

# configuring Postfix
RUN mv /etc/postfix/main.cf{,.orig}
ADD main.cf /etc/postfix/main.cf
RUN postconf -e "myhostname = mail.${DomainName}" \
 $$ postconf -e "mydestination = mail.${DomainName}, ${DomainName}, localhost.localdomain, localhost"

# configuring Dovecot
RUN mv /etc/dovecot/dovecot.conf{,.orig}
ADD dovecot.conf /etc/dovecot/dovecot.conf
RUN service postfix stop ; service dovecot stop

EXPOSE 25 143 110

CMD ["sh", "-c", "service postfix start ; service dovecot start ; service rsyslog start ; tail -f /dev/null"]
