class CommentSummaryMailer < ActionMailer::Base
  default from: "no-reply@magmaconf.com"

  def summary(user)
    email = user.profile && user.profile.email
    @today = Date.today.to_s(:db)
    subject = "Magmaconf - Comment Summary for #{@today}"
    @comments = Cfp::Comment.where(notified: false).group_by(&:proposal)

    if email && !@comments.empty?
      mail(to: email, subject: subject)
    end
  end
end
