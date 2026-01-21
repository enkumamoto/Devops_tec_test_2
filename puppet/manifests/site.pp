node 'bastion-host' {
  include basics
  include users
  include docker
  include phpmyadmin
  include monitoring
}
