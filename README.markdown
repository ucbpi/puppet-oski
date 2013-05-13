# Oski Function Library #

This module provides some useful library functions not found in stdlib

# Facts #

osplatform
----------

Contains the fact osplatform, which currently only supports RedHat distros.
For RHEL6 deriviatives, fact would contain 'el6', for RHEL5 deriviatives fact
would contain 'el5'.

ssh_dsa_fp
----------

The hosts SSH DSA fingerprint

ssh_rsa_fp
----------

The hosts SSH RSA fingerprint

# Functions #

any2bool
--------
Arguments:
- value : value to convert to a boolean

Given a string or boolean that looks like a boolean, it converts it to a bool.

Example:
<pre><code>
value = any2bool('f') # would be false
value = any2bool(true) # would be true
value = any2boold('1') # would be true
value = any2bool('') # would be false
</code></pre>

Truth Table:
<table>
<tr>
  <th>input</th>
  <th>output</th>
</tr>
<tr>
  <td>'1','t','y','true','yes'</td>
  <td>true</td>
</tr>
<tr>
  <td>'0','f','n','false','no'</td>
  <td>false</td>
</tr>
<tr>
  <td>'','undef','undefined'</td>
  <td>false</td>
</tr>
</table>

array_difference
----------------
Arguments:
- lhs : an array to have values subtracted from
- rhs : an array of values to subtract from $lhs

Given two arrays, lhs and rhs, removes the entries in rhs from lhs.

Example:
<pre><code>
$diff = array_difference( [ '1', '2', '3' ], [ '1', '3', '5' ])
</code></pre>

In this example, $diff would be the array [ '2' ]

array_intersect
---------------
Arguments:
- lhs : an array of values
- rhs : an array of values

Given two arrays, returns all elements that are in common to both arrays

Example:
<pre><code>
$incommon = array_intersect( [ '1', '2', '3' ], [ '1', '5', '8' ])
</code></pre>

In this example, $incommon would be the array [ '1' ]

lead
----
Arguments:
- value : Integer value to add leading zeroes
- width : Minimum width of integer

Given an integer value and width, ensures that integer value is *at least*
the provided width, inserting leading zeroes as necessary

params_lookup
-------------

Arguments:
- varname   : The variable name we want to define
- is_global : Should we look for this variable at the top level (ie. $::varname)
- default   : If no value is found, what should we set the default

This function looks up the value of a variable in multiple locations, providing
a simple way to ascertain a value from any of those locations.  The function
currently looks at the following locations, in order, returning the first one
found:

<ol>
  <li>Top-Scope Variable ($::class_[subclass_]*_varname)
    <p>
Useful for ENC support
    </p>
  </li>
  <li> Params Value ( $class::params::varname )

    <p>
This doesn't normally work in the top-level class, unless the class inherits the
params class, which is not a recommended practice.
    </p>
  </li>
  <li>Top-Scope Module Variable ($::module_varname)

    <p>
Again, useful for ENCs
    </p>
  </li>
  <li>Top-Scope Global varname ($::varname)

    <p>
Useful for ENCs and site.pp definitions.  Only valid if is_global is set to true
    </p>
  </li>
  <li>Default value

    <p>
Returns whatever we set as our default
    </p>
  </li>
  <li>Empty string

    <p>
If no default is set, we'll return an empty string.
    </p>
  </li>
</ol>

similar_elements
----------------
- array_lhs : An array of elements
- array_rhs : An array of elements

NOTE: this function has been deprecated in favor of using array_intersect()

Given two arrays, returns a single array with elements that are in common
between both. Essentially a logical AND of the two arrays

validate_ip
-----------
- ip : An string containing an ip address in CIDR format

Given an ipv4 address, validates the address and throws an error if its not a
properly formatted address.

License
-------

None

Contact
-------

Aaron Russo <arusso@berkeley.edu>

Support
-------

Please log tickets and issues at the
[Projects site](https://github.com/arusso23/puppet-oski/issues/)
