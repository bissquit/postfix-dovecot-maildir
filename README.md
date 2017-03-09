# Postfix and Dovecot with maildir
The simple configuration of Postfix and Dovecot with maildir store.

##Steps before container building

You need to manually change enviroments `DomainName` and `UserName` in dockerfile.

##Steps after container has build

You need to set up a password for mail user with sh-command

__passwd__ `username`

where `username` - the username whitch you set up in UserName enviroment in dockerfile.
