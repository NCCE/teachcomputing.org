class ResourcesFeedbackMailer < ApplicationMailer
  def feedback_request
    @user = params[:user]
    year = params[:year].to_s

    @feedback_links = { '1' => 'http://ncce.io/year1capture',
                        '2' => 'http://ncce.io/year2capture',
                        '3' => 'http://ncce.io/year3capture',
                        '4' => 'http://ncce.io/year4capture',
                        '5' => 'http://ncce.io/year5capture',
                        '6' => 'http://ncce.io/year6capture',
                        '7' => 'http://ncce.io/year7capture',
                        '8' => 'http://ncce.io/year8capture',
                        '9' => 'http://ncce.io/year9capture',
                        'KS4' => 'http://ncce.io/ks4capture' }

    @feedback_url = @feedback_links[year]

    mail(to: @user.email, subject: 'How are you finding the Resource Repository content?')
  end
end
