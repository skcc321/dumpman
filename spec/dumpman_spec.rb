require 'rake'
require 'spec_helper'

RSpec.describe Dumpman do
  it 'has a version number' do
    expect(Dumpman::VERSION).not_to be nil
  end
end
