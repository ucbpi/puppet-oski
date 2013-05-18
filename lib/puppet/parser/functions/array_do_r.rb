#
# array_do_r.rb
#
module Puppet::Parser::Functions
  newfunction(:array_do_r, :type => :rvalue, :doc => <<-EOS
When passed an array, a function name and parameters, executes the specified
function on each element of the array. Function result is returned as a hash of
the array element, and the result of the resulting function.

This function is especially useful when combined with validate_* -- you can now
apply the validation to within your arrays.

Example:

$addresses = [ '10.0.0.1', '10.0..0' ]
$ipv6_results = array_do_r( $addresses, 'is_ipv6' )
$valid_addresses = delete_hash_values( $ipv6_results, 'false' )
    EOS
  ) do |arguments|

    if arguments.size < 1 or arguments.size > 3
      raise( Puppet::ParseError,
            "array_do_r(): invalid arg count. must be 2 or 3." )
    end

    data = arguments[0]
    func = arguments[1]
    params = arguments[2] if arguments.size == 3

    # functions are required to pass anonymous arrays for parameters
    # so if we weren't given an array to prepend with our element
    # we'll convert it here
    if ! params.is_a?(Array)
      params = Array.new.push(params)
    end

    result = Hash.new 

    # Let's load our puppet function
    # TODO: validate its a good function
    Puppet::Parser::Functions.function(func)

    # iterate through each of our array elements, building our parameter
    # array and then executing our function.
    data.each do |element|
      args = params.dup.insert(0,element)
      args.compact!
      result[element] = send("function_#{func}", args)
    end

    return result
  end
end

# vim: set ts=2 sw=2 et :
