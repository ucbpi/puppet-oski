#
# ternary operator in function form
#
# ter.rb
#
module Puppet::Parser::Functions
  newfunction(:ter, :type => :rvalue, :doc => <<-EOS
function implementation of ternary operator.

examples:

  ter('text','text','text2')   # text2
  ter('text','notext','text2') # text
  ter('text','notext','text2','text3') # text3
  EOS
  ) do |arguments|

  raise(Puppet::ParseError, "ife(): Wrong number of arguments " +
        "given (#{arguments.size} for 3 or 4)") if arguments.size < 3 or \
        arguments.size > 4


    original = iffalse = arguments[0]
    compare = arguments[1]
    iftrue = arguments[2]
    iffalse = arguments[3] if arguments.size == 4

    if original == compare
      return iftrue
    else
      return iffalse
    end
  end
end

# vim: set ts=2 sw=2 et :
