class UserLog < ActiveRecord::Base
  belongs_to :user

  enum actions: %w{login logout session_expired relogged}

  validates :action, inclusion: {in: actions, message: '%{value} nie je akcia'}

  scope :of, -> (user) { where(user: user) }

  def self.log(resource, action)
    return unless User.valid_user?(resource) && (Rails.configuration.respond_to? :devise_usage_log_level)
    level = Rails.configuration.devise_usage_log_level
    if level == :all
      resource.log_action action
    end
  end
end
