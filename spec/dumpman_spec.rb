require "spec_helper"

RSpec.describe Dumpman do
  it "has a version number" do
    expect(Dumpman::VERSION).not_to be nil
  end

  it "does something useful" do
    expect{PostgresUser.create}.to change{PostgresUser.count}.by(1)
  end
end
