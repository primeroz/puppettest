# This facter fact returns the value of the network range for the main ip 
#
# This should be mostly useful for hierarchical data lookup


#begin
#  require 'facter/util/puppet_settings'
#rescue LoadError => e
#  # puppet apply does not add module lib directories to the $LOAD_PATH (See
#  # #4248). It should (in the future) but for the time being we need to be
#  # defensive which is what this rescue block is doing.
#  rb_file = File.join(File.dirname(__FILE__), 'util', 'puppet_settings.rb')
#  load rb_file if File.exists?(rb_file) or raise e
#end

Facter.add(:network_range) do
  setcode do
    #get route for google dns to deterine main network interface
    device=`ip route get 8.8.8.8 | egrep 8.8.8.8 | cut -d" " -f5`
    #get ip for interface
    device_ip=`ifconfig #{device} | egrep "^ +inet addr" | sed -e 's/:/ /g' | awk '{print $3}'`
    device_nm=`ifconfig #{device} | egrep "^ +inet addr" | sed -e 's/:/ /g' | awk '{print $7}'`

    case device_nm
    when /255\.255\.255\.0/
      "class_c"
    when /255\.255\.0\.0/
      "class_b"
    when /255\.0\.0\.0/
      "class_a"
    end
  end
end
