module Cron
  class MonthlyStatisticJob
    include Sidekiq::Worker

    def perform
      User.all.each do |user|
        MonthlyStatisticMailer.with(user: user).show.deliver_later
      end
    end
  end
end
