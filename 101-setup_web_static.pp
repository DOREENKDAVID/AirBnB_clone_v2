#setting up the web server and deploying web_static server_setup 
$nginx_conf = "server {
    listen 80 default_server;
    root /usr/share/nginx/html;
    index index.html index.htm;
    add_header X-Served-By 269747-web-01;
    location /redirect_me {
        return 301 https://github.com/DOREENKDAVID;
    }
    location /hbnb_static {
        alias /data/web_static/current;
    }
}"

  # Update package repositories and install nginx
package { 'nginx':
    ensure => 'installed',
}

  # Ensure that nginx service is running and enabled
service { 'nginx':
    ensure  => 'running',
    enable  => true,
    require => Package['nginx'],
}

  # Create directories and files
file { '/data/web_static/shared':
    ensure => 'directory',
    owner  => 'ubuntu',
    group  => 'ubuntu',
    mode   => '0755',
}

file { '/data/web_static/releases/test/index.html':
    ensure  => 'file',
    content => "Hello configuration successful\n",
    owner   => 'ubuntu',
    group   => 'ubuntu',
    mode    => '0644',
}

  # Create symbolic link
file { '/data/web_static/current':
    ensure => 'link',
    target => '/data/web_static/releases/test',
    owner  => 'ubuntu',
    group  => 'ubuntu',
}
exec { 'chown -Rubuntu:ubuntu /data/':
    path =>'/usr/bin/:/usr/local/bin/:/bin/'
	
}
file { '/var/www/html':
    ensure => 'directory'
}
file { '/var/www/html/index.html':
    ensure  => 'present',
    content => "Hello configuration successful\n"
}
file { '/var/www/html/404.html':
    ensure  => 'present',
    content => "Ceci n'est pas une page\n"
}
  # Configure Nginx
file { '/etc/nginx/sites-available/default':
    ensure  => 'file',
    content => $nginx_conf,
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  # Ensure Nginx is restarted after the configuration change
exec { 'nginx_restart':
    path => '/etc/init.d/'
}
