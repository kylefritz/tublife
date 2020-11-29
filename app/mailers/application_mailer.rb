class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@francaforthepeople.com'
  layout 'mailer'
  track open: true, click: true
end
