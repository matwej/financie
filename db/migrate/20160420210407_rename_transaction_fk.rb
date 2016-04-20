class RenameTransactionFk < ActiveRecord::Migration
  def change
    rename_column :transactions, :account_id, :owner_id
  end
end
