require 'bundler/inline'
gemfile do
  source 'https://rubygems.org'
  gem 'dotenv'
end

require 'net/smtp'
require 'dotenv/load'

module Notifier
  def notify_by_sms(interval)
    # Я не отправлял раньше смс в таких случаях,
    # но подход использовал бы тот же самый -
    # ENV-переменные с реквизитами для шлюза смс
    puts "Notify by sms #{notify_to}, #{interval}"
  end

  def notify_by_email(interval)
    message = <<-MESSAGE_END
      From: Monitoring Service <"#{ENV['SMTP_FROM']}">
      To: Notification Receiver <"#{notify_to}">
      Subject: Monitoring Results

      Resource unavailable for #{interval} minutes.
    MESSAGE_END

    Net::SMTP.start(ENV['SMTP_HOST']) do |smtp|
      begin
        smtp.send_message message, "#{ENV['SMTP_FROM']}", "#{notify_to}"
      rescue StandardError => e
        puts "Error: #{e.inspect}"
      end
   end
  end
end
