module Puppet::Parser::Functions
    newfunction(:arraystring_zpool, :type => :rvalue) do |args|
        pooltype    = args[0]
        poolvdevs   = args[1]

        arraystring = ""

        if poolvdevs[0].kind_of?(Array)
            poolvdevs.each do |diskSet|
                arraystring = arraystring+pooltype+' '+diskSet.join(' ')+' '
            end
        else
            diskSet=poolvdevs
            if pooltype == "none"
                arraystring = diskSet.join(' ')
            else
                arraystring = pooltype+' '+diskSet.join(' ')
            end
        end
        arraystring
    end
end
