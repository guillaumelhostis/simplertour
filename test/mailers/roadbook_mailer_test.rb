require "test_helper"

class RoadbookMailerTest < ActionMailer::TestCase
  test "roadbook_email" do
    mail = RoadbookMailer.roadbook_email
    assert_equal "Roadbook email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
