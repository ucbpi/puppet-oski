#
# similar_elements.rb
#
module Puppet::Parser::Functions
  newfunction(:similar_elements, :type => :rvalue, :doc => <<-EOS
Given two arrays, returns an array with all elements that are in common
  EOS
  ) do |arguments|
    raise(Puppet::ParseError, "similar_elements(): Wrong number of arguments " +
      "given (#{arguments.size} for 2)") if arguments.size < 2

    inner = Array(arguments[0])
    outer = Array(arguments[1])

    unless inner.is_a?(Array)
      raise(Puppet::ParseError, 'similar_elements(): expected array for parameter 1')
    end

    unless outer.is_a?(Array)
      raise(Puppet::ParseError, 'similar_elements(): expected array for paraemter 2')
    end

    result = [ ]
    inner.each do |i|
      if outer.include? i
        result.push i
      end
    end

    return result
  end
end

# vim: set ts=2 sw=2 et :
