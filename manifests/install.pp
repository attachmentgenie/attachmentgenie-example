# Class to install example.
#
# Dont include this class directly.
#
class example::install {
  if $::example::manage_user {
    user { $::example::user:
      ensure => present,
      home   => $::example::install_dir
    }
    group { $::example::group:
      ensure => present,
    }
  }
  case $::example::install_method {
    'package': {
      package { $::example::package_name:
        ensure => $::example::package_version,
      }
    }
    'archive': {
      file { $::example::install_dir:
        ensure => directory,
        group  => $::example::group,
        owner  => $::example::user,
      }
      if $::example::manage_user {
        File[$::example::install_dir] {
          require => [Group[$::example::group],User[$::example::user]],
        }
      }

      archive { '/tmp/example.tar.gz':
        cleanup         => true,
        creates         => "${::example::install_dir}/bin",
        extract         => true,
        extract_command => 'tar xfz %s --strip-components=1',
        extract_path    => $::example::install_dir,
        source          => $::example::archive_source,
        user            => $::example::user,
        group           => $::example::group,
        require         => File[$::example::install_dir]
      }

    }
    default: {
      fail("Installation method ${::example::install_method} not supported")
    }
  }
}