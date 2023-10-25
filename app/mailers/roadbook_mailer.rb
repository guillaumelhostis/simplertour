class RoadbookMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.roadbook_mailer.roadbook_email.subject
  #
  def roadbook_email(user)

    @user = user

    mail(to: @user.email, subject: 'New Roadbook has been created')
  end
end
