class xrdp (
	$manage_firewall = true,
) {
        file { '/etc/yum.repos.d/xrdp.repo':
                ensure => "file",
                owner  => "root",
                group  => "root",
                mode   => "644",
                content => "[xrdp]
name=xrdp
baseurl=http://li.nux.ro/download/nux/dextop/el7/x86_64/
enabled=1
gpgcheck=0
",}
        package { 'xrdp':
                ensure => present,
        }
        package { 'tigervnc-server':
                ensure => present,
        }
        service { 'xrdp':
                ensure => running,
                require => Package['xrdp'],
        }
	service { 'xrdp-sesman':
		ensure => running,
		require => Package['xrdp'],
	}
	#if ($manage_firewall) {
	#	firewall { 'Accept RDP':
	#		proto => 'tcp',
	#		port => 3389,
	#		action => 'accept',
	#	}
	#}
}
