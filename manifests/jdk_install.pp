class tomcat::jdk_install(

  $version        = '8',
  $install_dir    = ["/home/webapp/", "/home/webapp/java8u60","/home/webapp/tomcat.8.0.26",],
  $ensure         = 'installed',
  $update         = '60',
  $javaDownloadURI = "http://download.oracle.com/otn-pub/java/jdk/${version}u${update}-b27/jdk-${version}u${update}-linux-x64.tar.gz",
  $java_home      = "/home/webapp/java8u60/jdk1.8.0_60",
) inherits tomcat {

    file { $install_dir:
        ensure  => directory,
        owner   => webapp,
        mode    => 750,
      }

    exec { 'get_jdk_installer':
        cwd     => "/home/webapp/java8u60",
        command => "wget --no-check-certificate --no-cookies --header \"Cookie: oraclelicense=accept-securebackup-cookie\" http://download.oracle.com/otn-pub/java/jdk/${version}u${update}-b27/jdk-${version}u${update}-linux-x64.tar.gz",
        timeout => 600,
	path  => ['/usr/bin', '/usr/sbin', '/bin'],
      }

    exec { 'extract_jdk_installer':
        cwd     => "/home/webapp/java8u60",
        command => "tar -xvpf /home/webapp/java8u60/jdk-8u60-linux-x64.tar.gz",
        timeout => 600,
	creates => $java_home,
        path  => ['/usr/bin', '/usr/sbin', '/bin'],
	require => Exec['get_jdk_installer'],
      }

      exec { 'get_tomcat_installer':
        cwd     => "/home/webapp/tomcat.8.0.26",
        command => "wget --no-check-certificate --no-cookies --header \"Cookie: oraclelicense=accept-securebackup-cookie\" http://apache.mirrorcatalogs.com/tomcat/tomcat-8/v8.0.26/bin/apache-tomcat-8.0.26.tar.gz",
        timeout => 600,
        path  => ['/usr/bin', '/usr/sbin', '/bin'],
      
	}

       exec { 'extract_tomcat_installer':
        cwd     => "/home/webapp/tomcat.8.0.26",
        command => "tar -xvpf /home/webapp/tomcat.8.0.26/apache-tomcat-8.0.26.tar.gz",
        timeout => 600,
        path  => ['/usr/bin', '/usr/sbin', '/bin'],
        require => Exec['get_tomcat_installer'],
      }

       exec { 'set java' :
       command => "/bin/bash -c \"export PATH=/home/webapp/java8u60/jdk1.8.0_60/bin:$PATH\"",
   }

      exec { 'run tomcat' :
      command => "sh /home/webapp/tomcat.8.0.26/apache-tomcat-8.0.26/bin/catalina.sh start",
      path  => ['/usr/bin', '/usr/sbin', '/bin'],
      require => Exec['extract_tomcat_installer'],


     }
     





}
