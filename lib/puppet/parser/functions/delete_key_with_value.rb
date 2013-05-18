#
# delete_key_with_value.rb
#
module Puppet::Parser::Functions
  newfunction(:delete_key_with_value, :type => :rvalue, :doc => <<-EOS
When passed a hash table, and a match string/regex/boolean (or an array of),
this function will delete any key-value pairs it matches against.
    EOS
  ) do |arguments|

    if arguments.size != 2
      raise( Puppet::ParseError,
            "delete_key_with_value(): invalid arg count. must be 2." )
    end

    ht = arguments[0]
    val = arguments[1]

    if ! ht.is_a?(Hash)
      fail("delete_key_with_value(): you must pass a hash as argument #1")
    end

    # We'll allow a strings, regexes and booleans
    if val.is_a?(String) or val.is_a?(Regexp) or 
        val.is_a?(TrueClass) or val.is_a?(FalseClass)
      val = Array.new.push(val)
    elsif val.is_a?(Array) and val.size > 0
      val = val.dup
    else
      fail("delete_key_with_value(): you must provide a string/boolean/regex " +
            "or an array made up of any combination of those types" )
    end

    bool = [ TrueClass, FalseClass ]
    ht.each do |k,v|
      val.each do |m|
        ht.delete(k) if m.is_a?(Regexp) and v =~ m
        ht.delete(k) if ( m.is_a?(String) or bool.include?(m.class) ) and v == m
      end
    end

    return ht
  end
end

# vim: set ts=2 sw=2 et :
