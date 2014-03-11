#
# num2str.rb
#
module Puppet::Parser::Functions
  newfunction(:num2str, :type => :rvalue, :doc => <<-EOS
Convert numbers to strings.
EOS
  ) do |arguments|
    raise(Puppet::ParseError, "num2str(): Wrong number of arguments " +
      "given (#{arguments.size} for 1)") if arguments.size < 1

    num = arguments[0]

    return num if num.is_a?(String) and num =~ /^-?[0-9]+(?:\.[0-9]+)?$/
    raise(Puppet::ParseError, "num2str(): value #{num} is not a number and " +
      " appears to be a #{num.class}.") unless num.is_a?(Numeric)

    return num.to_s
  end
end

# vim: set ts=2 sw=2 et :
