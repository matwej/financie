class ApplicationMailer < ActionMailer::Base
  default from: 'notifications@financie.herokuapp.com'
  layout 'mailer'
end
