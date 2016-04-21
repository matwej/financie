class Transaction < ActiveRecord::Base
  belongs_to :category
  belongs_to :owner, class_name: 'Account', foreign_key: :owner_id

  validates :amount, presence: true, numericality: true
  validates :account, presence: true

  scope :category_filter, ->(category_id) { where(category_id: category_id) }
  scope :from_filter, ->(date) { where("transactions.processing_date >= ?", date) }
  scope :to_filter, ->(date) { where("transactions.processing_date < ?", date) }
  scope :text_filter, ->(text) { self.where("transactions.account ILIKE :s", s: "%#{text}%") }

  def self.apply_filters(objects, params)
    res = objects
    params.select{|param| param[/_filter$/] && !params[param].blank?}.each do |k,v|
      res = res.send(k,v)
    end
    res
  end

  def save_and_notify
    res = self.save
    notify self.owner if res
    res
  end

  def update_and_notify(params)
    res = self.update params
    notify self.owner if res
    res
  end

  private

  def notify(account)
    if account.notified && account.warning_limit <= account.sum_of_transactions
      UserMailer.warning_limit_email(account.user, account).deliver_now
    end
  end
end
