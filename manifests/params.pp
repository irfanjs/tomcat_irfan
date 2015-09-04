class tomcat::params {
  
  $package_ensure     = 'present'
  $package_name       = [ 'apache-tomcat' ]

  $service_dir        = '/usr/local/apache-tomcat'
}