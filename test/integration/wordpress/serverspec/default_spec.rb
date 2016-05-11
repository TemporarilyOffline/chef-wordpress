require 'serverspec'

set :backend, :exec

describe 'temporarilyoffline' do
  it 'should exist' do
    expect(user('temporarilyoffline')).to exist
  end
end

%w(php5-fpm curl).each do |pkg|
  describe 'apt' do
    it "Should install #{pkg}" do
      expect(package(pkg)).to be_installed
    end
  end
end