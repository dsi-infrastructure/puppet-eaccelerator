class eaccelerator {

    file { "/etc/php5/mods-available/eaccelerator.ini":
        owner   => 'root',
        group   => 'root',
        mode    => '0775',
        source  => 'puppet:///modules/eaccelerator/eaccelerator.ini',
        notify  => Exec['enable-eaccelerator'],
        require => Package['apache2'],
    }

    file { '/var/cache/eaccelerator':
        ensure => directory,
        owner  => 'root',
        group  => 'root',
        mode   => '0777',
    }

    file { '/usr/lib/php5/20100525/eaccelerator.so':
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0775',
        source  => 'puppet:///modules/eaccelerator/eaccelerator.so',
    }

    exec { 'enable-eaccelerator':
        command     => '/usr/sbin/php5enmod eaccelerator',
        refreshonly => true,
    }


    File['/usr/lib/php5/20100525/eaccelerator.so'] ->
    File['/var/cache/eaccelerator'] ->
    File['/etc/php5/mods-available/eaccelerator.ini']

}
