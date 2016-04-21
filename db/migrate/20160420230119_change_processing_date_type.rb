class ChangeProcessingDateType < ActiveRecord::Migration
  def change
    change_column :transactions, :processing_date, :date
  end
end
