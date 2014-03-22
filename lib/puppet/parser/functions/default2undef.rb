#
# default2undef.rb
#
# Test whether a given class or definition is defined
Puppet::Parser::Functions::newfunction(:default2undef, :type => :rvalue,
  :doc => "Given an input of a string and a default value, if the string matches
  the default value, the function returns undef. Otherwise, the function returns
  the string. If no default value is specified, 'UNSET' is used.

  For example:

      default2undef('something', 'UNSET') # returns 'something'
      default2undef('UNSET')              # returns undef
      default2undef('UNSET', 'UNSET')     # returns undef"
) do |arguments|
  raise(Puppet::ParseError, "default2undef(): Wrong number of arguments " +
        "given (#{arguments.size} for 1 or 2)") if ( arguments.size < 1 and
                                                      arguments.size > 2 )

  val = arguments[0]
  raise(Puppet::ParseError, "default2undef(): value provided must be a string,
        but it looks like a #{val.class}") unless val.is_a?(String)

  default_val = 'UNSET'
  default_val = arguments[1] if arguments[1] and arguments[1].is_a?(String)

  return val unless val == default_val 
  return :undef
end

# vim: set ts=2 sw=2 et :
