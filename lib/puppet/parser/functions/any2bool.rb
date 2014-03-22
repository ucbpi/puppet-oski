#
# any2bool.rb
#
# Reasonably convert any object or value to a boolean.
#
module Puppet::Parser::Functions
  newfunction(:any2bool, :type => :rvalue, :doc => <<-EOS
This converts any input to a boolean. This attempt to convert vals that 
contain things like: y, 1, t, true to 'true' and vals that contain things
like: 0, f, n, false, no to 'false'.
    EOS
  ) do |arguments|

    raise(Puppet::ParseError, "any2bool(): Wrong number of arguments " +
      "given (#{arguments.size} for 1)") if arguments.size < 1 or
                                          arguments.size > 2

    val = arguments[0]
    mode = 'valid'
    mode = arguments[1] if arguments.size > 1

    trues = [ 'y', 'yes', '1', 'true', 't', true ]
    falses = [ 'n', 'no', '0', 'false', 'f', false, '' ]

    case mode
    when 'valid'
      return true if trues.include? val
      return false if falses.include? val
    when 'def2true'
      return false if falses.include? val
      return true
    when 'def2false'
      return true if trues.include? val
      return false
    else
      raise(Puppet::ParseError, "any2bool(): Unknown mode #{mode}. Must be one
            of 'valid' (default), 'def2true', 'def2false'")
    end

    raise(Puppet::ParseError, "any2bool(): Unknown type of boolean given. Value
          #{val.inspect} (#{val.class}) is unexpected")
  end
end

# vim: set ts=2 sw=2 et :
