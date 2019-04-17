module Notifier
  def notify_by_sms(interval)
    puts "Notify by sms #{notify_to}, #{interval}"
  end

  def notify_by_email(interval)
    puts "Notify by email #{notify_to}, #{interval}"
  end
end
