class UserNotifier < ActionMailer::Base
  default :from => "admin@daddysocial.com"
  def signup_notification(user, url)
    @user = user
    @url = url
    mail(:to => user.email, :subject => 'Please activate your new DS account')
  end
end
