# Postfix and Dovecot with maildir
Simple configuration of Postfix and Dovecot with maildir store.

## Steps before container building

You need to download master-repository with git command:
  ```bash
  git clone https://github.com/bissquit/postfix-dovecot-maildir.git
  ```
or branches with -b <branch_name> option

## Use Tips

- Build image (in folder with dockerfile):
  ```bash
  docker build --build-arg DomainName=domain.com \
               --build-arg UserName=mailuser \
               --build-arg UserPass=mailuser_pass \
               -t mailserver .
  ```
  where domain.com - your mail domain, 
    mailuser - primary user;
    mailuser_pass - pass of primary user;
    mailserver - image name.
   
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
