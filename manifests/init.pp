# Forces an apt-get update upon puppet's first run, which
# is detected by the existence of a file
class firstrun ($firstrun_file = '/root/puppet_firstrun') {
	exec { 'apt-get update':
		unless => "test -f ${firstrun_file}"
	}

	anchor { 'firstrun::begin':
		before => File[$firstrun_file]
	}

	file { $firstrun_file:
		ensure => present,
		require => Exec['apt-get update']
	}

	anchor { 'firstrun::end':
		require => File[$firstrun_file]
	}
}
