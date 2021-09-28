class MonthlyStatisticMailer < ApplicationMailer
  default from: 'noreply@social_network.com'

  def show
    @user = params[:user]
    @statistic = UserProcessing::MonthlyStatistic.call(@user)

    mail(to: @user.email, subject: 'Monthly Statistic')
  end
end
