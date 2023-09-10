# Define a class for setting up the web server and deploying web_static
class web_server_setup {

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

  # Configure Nginx
  file { '/etc/nginx/sites-available/default':
    ensure  => 'file',
    content => template('my_module/nginx_config.config'),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  # Ensure Nginx is restarted after the configuration change
  Exec['nginx_reload'] -> Service['nginx']
}
