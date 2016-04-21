class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :categories, dependent: :destroy
  has_many :accounts, dependent: :destroy
  has_many :transactions, through: :accounts

  def self.valid_user?(resource)
    resource && resource.kind_of?(User) && resource.valid?
  end

  def log_action(action)
    UserLog.create!(user_id: id, ip: current_sign_in_ip, action: action)
  end

  def timedout?(last_access)
    res = super
    self.log_action :session_expired if res
    res
  end

  def update_unique_session_id!(unique_session_id)
    self.update_attribute(:unique_session_id, unique_session_id)
  end

  def max_value_transaction
    self.transactions.order("amount DESC").first
  end

  def min_value_transaction
    self.transactions.order("amount ASC").first
  end
end
