require 'spec_helper'

describe 'any2bool' do
  context "when mode = 'valid' (default)" do
    context 'acceptable true values' do
      it do
        true_vals = [ '1', 'y', 't', 'true', true, 'yes' ]
        true_vals.each { |v| should run.with_params(v,'valid').and_return(true) }
      end
    end

    context 'acceptable false values' do
      it do
        false_vals = [
          '0', 'f', 'false', false, 'no', :undef, 'undefined', '' ]
          false_vals.each { |v| should run.with_params(v,'valid').and_return(false) }
      end
    end
    context 'unknown type errors' do
      it do
        unknown_vals = [ '2', 's', [ ] ]
        unknown_vals.each do |v|
          expect {
            should run.with_params(v,'valid').and_return(true)
          }.to raise_error(Puppet::ParseError)
        end
      end
    end
  end

  context "when mode = 'def2true'" do
    context 'acceptable true values' do
      it do
        true_vals = [ '1', 'y', 'true', true, 'yes', 't', 'something', 's' ]
        true_vals.each { |v| should run.with_params(v,'def2true').and_return(true) }
      end
    end
    context 'acceptable false values' do
      it do
        false_vals = [ '0', 'f', 'false', false, 'no', '', 'something', 's' ]
        false_vals.each { |v| should run.with_params(v,'def2true').and_return(false) }
      end
    end
  end

  context "when mode = 'def2false'" do
    context 'acceptable true values' do
      it do
        true_vals = [ '1', 'y', 'true', true, 'yes', 't' ]
        true_vals.each { |v| should run.with_params(v,'def2false').and_return(true) }
      end
    end
    context 'acceptable false values' do
      it do
        false_vals = [ '0', 'f', 'false', false, 'no', '', 'something', 's' ]
        false_vals.each { |v| should run.with_params(v,'def2false').and_return(false) }
      end
    end
  end

  context "bad mode" do
    it do
      expect {
        should run.with_params('a', 'badmode').and_return(true)
      }.to raise_error(Puppet::ParseError,/Unknown mode/)
    end
  end
end
