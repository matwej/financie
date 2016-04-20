class AddLoginTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :log_token, :string
  end
end
