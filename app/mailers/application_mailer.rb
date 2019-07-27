# frozen_string_literal: true

# :nocov:
# Application mailer
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
# :nocov:
