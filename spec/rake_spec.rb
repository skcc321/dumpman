require "rake"
require "spec_helper"

RSpec.describe Dumpman do
  context 'rake task' do
    context 'conservation' do
      describe 'db:dump' do
        it "creates db dump file" do
          expect do
            Rake::Task['db:dump'].invoke
          end.to change { File.exists?(Dumpman.dump_file_name) }.from(false).to(true)
        end
      end

      describe 'db:compress' do
        it "creates zip file with db dump" do
          expect do
            Rake::Task['db:compress'].invoke
          end.to change { File.exists?(Dumpman.dump_zip_name) }.from(false).to(true)
        end
      end
    end

    context 'extraction' do
      describe 'db:restore' do
        it "restores db from dump file" do
          Rake::Task['db:create'].invoke
          Rake::Task['db:migrate'].invoke
          # PostgresUser.create(name: 'test name')

          Rake::Task['db:dump'].invoke
          #
          # PostgresUser.destroy_all

          Rake::Task['db:restore'].invoke
          #
          # expect(PostgresUser.count).to eq(1)
        end
      end
    end
  end
end
