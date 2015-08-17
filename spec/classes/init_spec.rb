require 'spec_helper'
describe 'file_header' do

  context 'with defaults for all parameters' do
    it { should contain_class('file_header') }
  end
end
