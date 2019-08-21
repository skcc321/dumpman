require 'rake'
require 'spec_helper'

RSpec.describe Dumpman do
  it 'has a version number' do
    expect(Dumpman::VERSION).not_to be nil
  end

  it 'fetch user value from database config' do
    user      = 'dummy user'
    instance  = Dumpman::Adapters::Base.instance

    allow_any_instance_of(Dumpman::Adapters::Base).to receive(:db_config).and_return({user: user})

    expect(instance.send(:username)).to eq(user)
  end
end
