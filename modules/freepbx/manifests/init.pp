
class freepbx () inherits freepbx::params {

  #import "definitions/*.pp"

    include "freepbx::install"

    anchor { 'freepbx::begin': }
    anchor { 'freepbx::end': }

    Anchor['freepbx::begin'] -> Class['freepbx::install'] 
        -> Anchor['freepbx::end']

}
