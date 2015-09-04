# Class: tomcat
#
# This module manages tomcat
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class tomcat (
  $package_name       = $tomcat::params::package_name,
  $package_ensure     = $tomcat::params::package_ensure,
  
) inherits tomcat::params {


  anchor { 'tomcat::start': }->
      class { 'tomcat::create_user': }->
      class { 'tomcat::jdk_install': }->
      class { 'tomcat::install':  }->
      class { 'tomcat::config': }->
  anchor { 'tomcat::end': }
  
}
