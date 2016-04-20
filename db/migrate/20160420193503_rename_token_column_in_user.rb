class RenameTokenColumnInUser < ActiveRecord::Migration
  def change
    rename_column :users, :log_token, :unique_session_id
  end
end
