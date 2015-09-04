define tomcat::web($path) {
 
  include tomcat
 
  file { "/usr/local/apache-tomcat/webapps/${name}.war":
	owner => 'root',
	source => $path,
  }

}
