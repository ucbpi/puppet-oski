#
# bool2str.rb
#
module Puppet::Parser::Functions
  newfunction(:bool2str, :type => :rvalue, :doc => <<-EOS
This converts a boolean input into a string.  If the input passed is a
string or undefined, that value is returned as well
    EOS
  ) do |arguments|

    raise(Puppet::ParseError, "bool2int(): Wrong number of arguments " +
      "given (#{arguments.size} for 1 or 2)") if ( arguments.size < 1 and
                                                   arguments.size > 2 )

    bool = arguments[0]
    strict = arguments[1]

    if strict.is_a? FalseClass; strict = false 
    else; strict = true; end
    
    return bool if bool.is_a? String and not strict
    return bool if bool == :undefined and not strict

    result = case bool
      when true then 'true'
      when false then 'false'
      else
          raise(Puppet::ParseError, "bool2str(): you didn't pass me a bool,
            and you either set strict true, or its false and you passed
            #{bool}, which was unexpected.  I'm telling mom." )
    end

    return result

  end
end

# vim: set ts=2 sw=2 et :
