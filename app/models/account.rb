class Account < ActiveRecord::Base
  belongs_to :user
  has_many :transactions, dependent: :destroy, foreign_key: :owner_id

  validates :name, presence: true

  def sum_of_transactions
    self.transactions.sum(:amount)
  end
end
