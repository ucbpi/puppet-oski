# Oski Function Library #

This module provides some useful library functions not found in stdlib

# Facts #


## osplatform ##

Contains the fact osplatform, which currently only supports RedHat distros. For
RHEL6 deriviatives, fact would contain 'el6', for RHEL5 deriviatives fact would
contain 'el5'. 

## ssh\_dsa\_fp ##

The host's SSH DSA fingerprint

## ssh\_rsa\_fp ##

The host's SSH RSA fingerprint

## hostname\_s\# ##

Splits a hostname by the '-' character, and presents each segment as a separate
fact. For example, hostname 'node-blah-prod' would be:

- <tt>hostname\_s1</tt>: node
- <tt>hostname\_s2</tt>: blah
- <tt>hostname\_s3</tt>: prod

# Functions #

## any2bool ##

*Given a string or boolean that looks like a boolean, it converts it to a bool.*

Arguments:

- value : value to convert to a boolean

*Example:*

```
any2bool('f')
any2bool(true)
any2boold('1')
any2bool('')
any2bool('arusso')
```

Would Result In:

```
false
true
true
false
Parse Error
```

Truth Table:

|            Input             | Output |
| ---------------------------- | ------ |
| '1', 't', 'y', 'true', 'yes' | true   |
| '0', 'f', 'n', 'false', 'no' | false  |
| '', 'undef', 'undefined'     | false  |
| default                      | Error  |

## array\_difference ##

*Given two arrays, lhs and rhs, removes the entries in rhs from lhs.*

Arguments:

- lhs : an array to have values subtracted from
- rhs : an array of values to subtract from $lhs

*Example:*

```
array_difference( [ '1', '2', '3' ], [ '1', '3', '5' ])
```

Would result in:

```
[ '2' ]
```

## array\_do ##

*Takes an array of values, and iterates over the array while executing the
function 'func' against all of the values.  If passed a string/array of
additional values, those will be appended to the iterated value as the
parameter array to the function.*

Arguments:

- values : an array of values to iterate over
- func : function to execute against the elements of $values
- params : additional parameters to pass to the function


*Example:*

```
$usernames = [ 'tom', 'jerry', 'bruno', 'myrtle' ]
array_do( $usernames, 'validate_re', '^(tom|jerry|bruno)$' )
```

Would result in a parse error, since <tt>myrtle</tt> would not match the
validat\_re call:

```
validate_re('myrtle','^(tom|jerry|bruno)$')
```

## array\_do\_r ##

*Takes an array of values, and iterates over the array while executing the
function 'func' against all of the values.  If passed a string/array of
additional values, those will be appended to the iterated value as the parameter
array to the function.*

Arguments:

- values: an array of values to iterate over
- func : function to execute against the elemnts of $values
- params : additional parameters to pass the function


This function returns the output in a hash, with each iterated element as the
key, and the output as the value.

*Example:*

```
$ips = [ '127.0.0.1', '::1', '192.168.0.0/24' ]
$out = array_do_r( $ips, 'is_ipv6' )
delete_key_with_value( $out, false )
```

Would result in:

```
{ '::1' => true }
```

## array\_intersect ##

*Given two arrays, returns all elements that are in common to both arrays*

Arguments:

- lhs : an array of values
- rhs : an array of values

*Example:*

```
$incommon = array_intersect( [ '1', '2', '3' ], [ '1', '5', '8' ])
```

Would result in:

```
[ '1' ]
```

## bool2str ##

*Converts a boolean to string*

## delete\_key\_with\_value ##

*When passed a hash table, and a match string/regex/boolean (or an array of),
this function will delete any key-value pairs it matches against.*

Arguments:

- hash : hash table of values to work with
- value : the value of the keys to delete

## is\_ipv4 ##

*Returns true if the string passed is an ipv4 address/network.  Returns false
otherwise.*

Arguments:

- string value

## is\_ipv6 ##

*Returns true if the string passed is an ipv6 address/network. Returns false
otherwise.*

Arguments:

- string value

## lead ##

*Given an integer value and width, ensures that integer value is *at least*
the provided width, inserting leading zeroes as necessary*

Arguments:

- value : Integer value to add leading zeroes
- width : Minimum width of integer

*Example:*

```
lead( 4, 3 )
lead( 22, 4)
```

Would result in:

```
'004'
'0022'
```

## num2str ##

*Converts any numeric type to a string. If a string is formatted like a number.*

Arguments:

- num : numeric value

*Example:*

```
num2str( 4 )
num2str( '-6' )
num2str( -1.23 )
num2str( '2.56' )
```

Would result in:

```
'4'
'-6'
'-1.23'
'2.56'
```

## params\_lookup ##

*This function looks up the value of a variable in multiple locations, providing
a simple way to ascertain a value from any of those locations.  The function
currently looks at the following locations, in order, returning the first one
found.*

**Note:** This function is deprecated, and will be removed in later versions of
this module

Arguments:

- varname   : The variable name we want to define
- is\_global : Should we look for this variable at the top level (ie. $::varname)
- default   : If no value is found, what should we set the default

1.  Top-Scope Variable ($::class\_[subclass\_]*\_varname)

    Useful for ENC support
2.  Params Value ( $class::params::varname )

    This doesn't normally work in the top-level class, unless the class inherits
    the params class, which is not a recommended practice.

3.  Top-Scope Module Variable ($::module\_varname)

    Again, useful for ENCs

4.  Top-Scope Global varname ($::varname)

    Useful for ENCs and site.pp definitions.  Only valid if is_global is set to
    true
  
5.  Default value

    Returns whatever we set as our default
  
6.  Empty string

    If no default is set, we'll return an empty string.

similar\_elements
----------------

*Given two arrays, returns a single array with elements that are in common
between both. Essentially a logical AND of the two arrays*

**Note:** this function has been deprecated in favor of using array\_intersect()

Arguments:

- array\_lhs : An array of elements
- array\_rhs : An array of elements

*Example:*

```
similar_elements(['1','2','9'],['2','3','9'])
```

Would result in:

```
[ '2', '9' ]
```

## validate\_ip ##

*Given an ipv4 address, validates the address and throws an error if its not a
properly formatted address.*

Arguments:

- ip : An string containing an ip address in CIDR format

*Example:*

```
validate_ip('192.168.0.1/24')
validate_ip('10.0.0.2')
validate_ip('alphabet soup')
validate_ip('2600::1/64')
```

Would result in:

```
true
true
false
false
```


License
-------

See LICENSE file

Copyright
---------

Copyright &copy; 2014 The Regents of the University of California

Contact
-------

Aaron Russo <arusso@berkeley.edu>

Support
-------

Please log tickets and issues at the
[Projects site](https://github.com/arusso/puppet-oski/issues/)
