require 'rake'
require 'spec_helper'

RSpec.describe Dumpman do
  context 'conservation' do
    describe 'db:dump' do
      it 'creates db dump file' do
        expect do
          Rake::Task['db:dump'].reenable
          Rake::Task['db:dump'].invoke
        end.to change { File.exists?(Dumpman.dump_file_name) }.from(false).to(true)
      end
    end
  end
end
