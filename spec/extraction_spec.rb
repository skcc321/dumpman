require "rake"
require "spec_helper"

RSpec.describe Dumpman do
  context 'extraction' do
    describe 'db:restore' do
      it "restores db from dump file" do
        PostgresUser.destroy_all
        PostgresUser.create(name: 'test name')
        Rake::Task['db:dump'].reenable
        Rake::Task['db:dump'].invoke

        PostgresUser.destroy_all
        Rake::Task['db:restore'].reenable
        Rake::Task['db:restore'].invoke

        expect(PostgresUser.count).to eq(1)
      end
    end
  end
end
