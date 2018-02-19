class CreatePostgresUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :postgres_users do |t|
      t.string :name

      t.timestamps
    end
  end
end
