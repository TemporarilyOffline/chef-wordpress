name             'wordpress'
maintainer       'temporarilyoffline'
maintainer_email 'temporarilyoffline@gmail.com'
description      'Sets up a simple stack for When I Work'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

depends 'mysql'
depends 'hhvm'
depends 'nginx'
depends 'database'
depends 'mysql2_chef_gem'
depends 'sudo'
