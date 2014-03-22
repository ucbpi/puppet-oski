require 'spec_helper'

describe 'bool2str' do
  context 'when strict' do
    it do
      should run.with_params(true).and_return('true')
      should run.with_params(false).and_return('false')

      expect {
        should run.with_params('test').and_return('test')
        should run.with_params(['blah']).and_return(['blah'])
        should run.with_params('true').and_return('true')
      }.to raise_error(Puppet::ParseError)
    end
  end
  context 'when non-strict' do
    it {
      should run.with_params('true',false).and_return('true')
      should run.with_params(true,false).and_return('true')
      should run.with_params('false',false).and_return('false')
      should run.with_params(false,false).and_return('false')
      should run.with_params('test',false).and_return('test')

      expect {
        should run.with_params(:undef,false).and_return(:undef)
      }.to raise_error(Puppet::ParseError)
    }
  end
end
