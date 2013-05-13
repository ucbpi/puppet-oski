#
# array_intersect.rb
#
module Puppet::Parser::Functions
  newfunction(:array_intersect, :type => :rvalue, :doc => <<-EOS
Given two arrays, returns all elements that exist in both.
  EOS
  ) do |arguments|
    raise(Puppet::ParseError, "array_intersect(): Wrong number of arguments " +
      "given (#{arguments.size} for 2)") if arguments.size < 2

    lhs = Array(arguments[0])
    rhs = Array(arguments[1])

    unless lhs.is_a?(Array)
      raise(Puppet::ParseError, 'array_intersect(): expected array for parameter 1')
    end

    unless rhs.is_a?(Array)
      raise(Puppet::ParseError, 'array_intersect(): expected array for paraemter 2')
    end

    result = lhs & rhs
    return result
  end
end

# vim: set ts=2 sw=2 et :
