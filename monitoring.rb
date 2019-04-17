require 'net/http'
require './notifier'

class Monitoring
  include Notifier
  attr_reader :url, :notify_to

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  CHECK_INTERVALS = %w(3 10 50 100 500)

  def initialize(*args)
    raise ArgumentError, "Incorrect arguments #{args.inspect}" if args.size < 2
    @url, @notify_to = args
  end

  def notify(interval)
    if notify_to.match?(EMAIL_REGEX)
      notify_by_email(interval)
    else
      notify_by_sms(interval)
    end
  end

  def start
    status = 0
    uri = URI(url)
    begin
      thread = Thread.new do
        CHECK_INTERVALS.each do |interval|
          response = Net::HTTP.get_response(uri)
          if response.code == "200"
            status = 1
            thread.exit
          end
          notify(interval)
          sleep(interval.to_i * 60)
        end
      end
      thread.join
    rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, Errno::EHOSTUNREACH, EOFError,
           Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError, Net::ReadTimeout => e
      puts e.inspect
    else
      case status
      when 0
        puts "Resource unavailable."
      when 1
        puts "Resource available."
      end
    end
  end
end

Monitoring.new(*ARGV).start
