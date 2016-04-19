class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.decimal :warning_limit, precision: 10, scale: 2
      t.boolean :notified
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
