class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def warning_limit_email(user, account)
    @user = user
    @account = account
    mail(to: @user.email, subject: 'Upozornenie na prekročenie limitu')
  end
end
