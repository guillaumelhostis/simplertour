class RoadbookMailer < ApplicationMailer
  default from: 'guillaume.lhostis@free.fr'
  def roadbook_email(user)
    @user = user
    pdf_data = session[:pdf_data]
    attachments['Roadbook.pdf'] = File.read(pdf_data.path)
    mail(to: @user.email, subject: 'New Roadbook has been created')
  end
end
