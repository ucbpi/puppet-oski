#
# is_ipv4.rb
#
module Puppet::Parser::Functions
  newfunction(:is_ipv4, :type => :rvalue, :doc => <<-EOS
Given a string, returns true if it is a valid ipv4 address or subnet
    EOS
  ) do |arguments|

    # Verify we've got the right number of arguments. This is the only error
    # we should be throwing
    if arguments.size != 1
      raise( Puppet::ParseError, "is_ipv4(): wrong number of arguments " +
            "given. #{arguments.size} for 1" )
    end
    input = arguments[0]

    require 'ipaddr'

    begin
      addr = IPAddr.new(input)
    rescue
      return false
    end

    return true if addr.ipv4?
    return false
  end
end

# vim: set ts=2 sw=2 et :
