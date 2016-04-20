class RemoveEmailFromUserLog < ActiveRecord::Migration
  def change
    remove_column :user_logs, :email
  end
end
