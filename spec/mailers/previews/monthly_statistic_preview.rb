# Preview all emails at http://localhost:3000/rails/mailers/monthly_statistic
class MonthlyStatisticPreview < ActionMailer::Preview
  def show
    MonthlyStatisticMailer.with(user: User.first).show
  end
end
