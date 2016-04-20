class CreateUserLogs < ActiveRecord::Migration
  def change
    create_table :user_logs do |t|
      t.integer :user_id, null: false
      t.string :ip
      t.string :email
      t.string :action

      t.timestamps null: false
    end

    add_index :user_logs, :user_id
    add_foreign_key :user_logs, :users
  end
end
