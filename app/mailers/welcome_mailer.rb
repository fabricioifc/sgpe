class WelcomeMailer < ApplicationMailer

  def welcome_email(user_id)
    @user = User.find(user_id)

    mail(:to => 'fabricio.bizotto@ifc.edu.br', :subject => "Bem vindo!") do |format|
      format.text
      format.html
    end unless @user.nil?
  end
end
