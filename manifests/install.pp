#
class tomcat::install inherits tomcat {
  
  package { 'apache-tomcat':
    ensure =>  $package_ensure,
    name   =>  $package_name,
  }


  service { "tomcat" :
    provider => "init",
    ensure => running,
  }
  
  }
