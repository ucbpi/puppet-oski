require 'spec_helper'

describe 'default2undef' do
  context 'standard battery' do
    it {
      should run.with_params('normal string').and_return('normal string')
      should run.with_params('UNSET').and_return(:undef)
      should run.with_params('UNSET','default').and_return('UNSET')
      should run.with_params('normal','default').and_return('normal')
    }
  end
end
