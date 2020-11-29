class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@tubs.fritz.io'
  layout 'mailer'
  track open: true, click: true
end
