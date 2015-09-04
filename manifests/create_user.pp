class tomcat::create_user inherits tomcat {
  user {'webapp':
 
  name => webapp,
  ensure => present,
  shell => '/bin/bash',
  }
}
 
