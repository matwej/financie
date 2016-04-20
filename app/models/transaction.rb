class Transaction < ActiveRecord::Base
  belongs_to :category
  belongs_to :owner, class_name: 'Account', foreign_key: :owner_id

  validates :amount, presence: true, numericality: true
  validates :account, presence: true
end
