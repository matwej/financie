class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :account
      t.datetime :processing_date
      t.string :description
      t.decimal :amount, precision: 10, scale: 2
      t.references :category, index: true, foreign_key: true
      t.references :account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
