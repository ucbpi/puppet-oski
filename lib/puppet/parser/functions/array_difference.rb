#
# array_difference.rb
#
module Puppet::Parser::Functions
  newfunction(:array_difference, :type => :rvalue, :doc => <<-EOS
Provided two arrays, lhs and rhs, returns lhs - rhs.
  EOS
  ) do |arguments|
    raise(Puppet::ParseError, "array_difference(): Wrong number of arguments " +
      "given (#{arguments.size} for 2)") if arguments.size < 2

    lhs = Array(arguments[0])
    rhs = Array(arguments[1])

    unless lhs.is_a?(Array)
      raise(Puppet::ParseError, 'array_difference(): expected array for parameter 1')
    end

    unless rhs.is_a?(Array)
      raise(Puppet::ParseError, 'array_difference(): expected array for paraemter 2')
    end

    result = Array.new
    result = lhs - rhs

    return result
  end
end

# vim: set ts=2 sw=2 et :
