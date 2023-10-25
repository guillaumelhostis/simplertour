# Preview all emails at http://localhost:3000/rails/mailers/roadbook_mailer
class RoadbookMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/roadbook_mailer/roadbook_email
  def roadbook_email
    RoadbookMailer.roadbook_email
  end

end
