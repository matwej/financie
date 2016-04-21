class Category < ActiveRecord::Base
  belongs_to :user
  has_many :transactions

  scope :of, -> (user) { where(user_id: user.id) }
  scope :transactions_from, ->(date) { joins(:transactions).where("transactions.processing_date >= ?", date).select("categories.*") }
  scope :transactions_to, ->(date) { joins(:transactions).where("transactions.processing_date < ?", date).select("categories.*") }

  validates :name, presence: true
end
