#
# params_lookup.rb
#
# This function lookups for a variable value in various locations.
# In particular, this function will look for variables in the order
# of most-specific to most-general, with ENC values taking precedence
# over those defined in a manifest.
#
# The exact order is:
# - ::classname_[subclassname_]*var - class specific ENC/site.pp
# - ::classname::subclass::params   - class specific manifest
# - ::modulename_var                - module default ENC/site.pp
# - ::modulename::params::varname   - module default manifest
# - ::varname (if second argument is 'global') - global default
# - default value (third argument)
# - empty string (if no default provided)
#
# Code adapted from Example 42's params_lookup function by
#   Alessandro Franceschi al@lab42.it
#
module Puppet::Parser::Functions
  newfunction(:params_lookup, :type => :rvalue, :doc => <<-EOS
This fuction looks for the given variable name in a set of different sources:
- ::varname (if is_global is true) 
- ::classname_subclass_varname
- ::modulename_varname
- ::modulename::params::varname
If no value is found in the defined sources, it returns an empty string ('')
    EOS
  ) do |arguments|

    raise(Puppet::ParseError, "params_lookup(): Define at least the variable name " +
      "given (#{arguments.size} for 1)") if arguments.size < 1

    value = ''
    var_name = arguments[0]
    is_global = arguments[1]
    default_value = arguments[2]
    module_name = parent_module_name
    classname = self.resource.name.downcase
    loaded_classes = catalog.classes
    
    # Top Scope Variable ::class_[sub_]_varname
    value = lookupvar("::#{classname.gsub('::','_')}_#{var_name}")
    return value if (not value.nil?) && (value != :undefined) && (value != '')

    # self::params class lookup for default value
    if loaded_classes.include?("#{classname}::params")
      value = lookupvar("::#{classname}::params::#{var_name}")
      return value if (not value.nil?) && (value != :undefined) && (value != '')
    end

    # Top Scope Variable Lookup (::modulename_varname)
    value = lookupvar("::#{module_name}_#{var_name}")
    return value if (not value.nil?) && (value != :undefined) && (value != '')

    # Params class lookup for default value
    if loaded_classes.include?("#{module_name}::params")
      value = lookupvar("::#{module_name}::params::#{var_name}")
      return value if (not value.nil?) && (value != :undefined) && (value != '')
    end

    # Look up ::varname (if we've set is_global to true) 
    if is_global
      value = lookupvar("::#{var_name}")
      return value if (not value.nil?) && (value != :undefined) && (value != '')
    end

    # Return our passed in default
    return default_value if ( not default_value.nil? ) && (default_value != :undefined)

    # Return the empty string
    return ''
  end
end
