require 'spec_helper'
describe 'known_hosts' do

  context 'with defaults for all parameters' do
    let(:facts) { {:concat_basedir => '/tmp'} }
    it { should contain_class('known_hosts') }
  end
end
