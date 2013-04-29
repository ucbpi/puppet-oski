#
# lead.rb
#
module Puppet::Parser::Functions
  newfunction(:lead, :type => :rvalue, :doc => <<-EOS
This takes an input of an integer, and returns it to a string with leading
zeroes.
  EOS
  ) do |arguments|

    raise(Puppet::ParseError, "lead(): Wrong number of arguments " +
      "given (#{arguments.size} for 2)") if arguments.size < 2

    value = Integer(arguments[0])
    width = Integer(arguments[1])

    unless value.is_a?(Integer)
      raise(Puppet::ParseError, 'lead(): expected integer for value parameter')
    end

    unless width.is_a?(Integer)
      raise(Puppet::ParseError, 'lead(): expected integer for width parameter')
    end


    result = "%0#{width}i" % value

    if result.size > width
      raise(Puppet::ParseError, 'lead(): passed in value is longer than width' )
    end

    return result
  end
end

# vim: set ts=2 sw=2 et :
