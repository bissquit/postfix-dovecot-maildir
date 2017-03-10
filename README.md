# Postfix and Dovecot with maildir
The simple configuration of Postfix and Dovecot with maildir store.

##Steps before container building

You need to manually change enviroments `DomainName` and `UserName` in dockerfile.

##Steps after container has build

You need to set up a password for mail user with sh-command:
  ```bash
  passwd username
  ```

where `username` - the username whitch you set up in UserName enviroment in dockerfile.

##Additional comments

- Build image (in folder with dockerfile):
  ```bash
  docker build -t mailserver .
  ```

- Run container:
  ```bash
  docker run -dit -p 25:25 \ 
                  -p 143:143 \
                  -p 110:110 \
                  mailserver
  ```
                
- Open shell inside container in interactive mode:
  ```bash
  docker exec -it b8610b5cea19 /bin/bash
  ```

  where `b8610b5cea19` - container id (list with command `docker ps -a`)


see more at http://blog.bissquit.com/mail-servers/unix-mail/bazovaya-nastrojka-postfix-i-dovecot/
