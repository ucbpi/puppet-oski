source 'https://rubygems.org'

if ENV.key?('PUPPET_VERSION')
  puppetversion = "#{ENV['PUPPET_VERSION']}"
 else
   puppetversion = "~> 2.7.0"
end

gem 'rake'
gem 'puppet-lint'
gem 'rspec-puppet',
  :git => 'git://github.com/rodjek/rspec-puppet'

gem 'puppet', puppetversion
gem 'puppetlabs_spec_helper'
gem 'rspec', "< 3.0.0"
