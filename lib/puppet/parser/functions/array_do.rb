#
# array_do.rb
#
module Puppet::Parser::Functions
  newfunction(:array_do, :type => :rvalue, :doc => <<-EOS
When passed an array, a function name and parameters, executes the specified
function on each element of the array. Function result is returned as a hash of
the array element, and the result of the resulting function.
    EOS
  ) do |arguments|

    if arguments.size < 1 or arguments.size > 3
      raise( Puppet::ParseError,
            "array_do(): invalid arg count. must be 2 or 3." )
    end

    data = arguments[0]
    func = arguments[1]
    params = arguments[2] if arguments.size == 3

    result = Hash.new 

    Puppet::Parser::Functions.function(func)

    count = 0
    data.each do |element|
      args = [ element, params ]
      args.compact!
      result[element] = send("function_#{func}", args)
    end

    return result
  end
end

# vim: set ts=2 sw=2 et :
