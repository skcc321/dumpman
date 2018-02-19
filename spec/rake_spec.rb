require "rake"
require "spec_helper"

RSpec.describe Dumpman do
  context 'rake task' do
    describe 'db:compress' do
      it "creates zip file with db dump" do
        expect do
          Rake::Task['db:compress'].invoke
        end.to change { File.exists?(Dumpman.dump_zip_name) }.from(false).to(true)
      end
    end
  end
end
