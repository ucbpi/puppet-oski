#
# validate_cidr.rb
#
module Puppet::Parser::Functions
  newfunction(:validate_cidr, :doc => <<-EOS
does nothing if the ip is a cidr-formatted ipv4 address. If prefix is left off,
/32 is assumed
    EOS
  ) do |arguments|

    raise(Puppet::ParseError, "validate_cidr(): Wrong number of arguments " +
      "given (#{arguments.size} for 1-2)") if arguments.size < 1 or arguments.size > 2

    ip = arguments[0]
    ver = arguments[1] if arguments.size = 2

    require 'ipaddr'

    begin
      IPAddr.new(ip)
    rescue
      raise(Puppet::ParseError, "validate_cidr(): invalid ip address - #{ip}")
    end

    if ver != nil and ver.to_s == "4"
      raise(Puppet::ParseError, "validate_cidr(): invalid ipv4 address - #{ip}")
    end

  end
end

# vim: set ts=2 sw=2 et :
