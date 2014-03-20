class ResultsMailer < ActionMailer::Base
  default from: "noreply@fantasysliding.com"
  
  def results_email(prediction)
    @prediction = prediction
    @user = @prediction.user
    mail(:to => @user.email, :subject => "Fantasy Sliding Results")
  end
  
end
