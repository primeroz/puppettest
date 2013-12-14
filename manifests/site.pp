# /etc/puppet/manifests/site.pp

# import many manifest files with node definitions
#import 'nodes/*.pp'

hiera_include('classes')

import 'roles/*.pp'
import 'virtual/*.pp'
