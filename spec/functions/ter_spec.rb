require 'spec_helper'

describe 'ter' do
  it do
    should run.with_params('same','same','t').and_return('t')
    should run.with_params(true,true,'t').and_return('t')
    should run.with_params('same','same',true).and_return(true)

    should run.with_params('same','same','t','f').and_return('t')
    should run.with_params(true,true,'t','f').and_return('t')
    should run.with_params('same','same',true,false).and_return(true)

    should run.with_params('same','diff','t').and_return('same')
    should run.with_params(true,false,'t').and_return(true)
    should run.with_params(true,false,false).and_return(true)

    should run.with_params('same','diff','t','f').and_return('f')
    should run.with_params(true,false,'t','f').and_return('f')
    should run.with_params(true,false,true,false).and_return(false)
  end
end
