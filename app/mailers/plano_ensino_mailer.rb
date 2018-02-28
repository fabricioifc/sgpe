class PlanoEnsinoMailer < ApplicationMailer
  helper :application
  # default template_path: 'devise/mailer'
  add_template_helper EmailHelper
  add_template_helper ApplicationHelper

  def enviar_aviso_nupe(**args)
    @args = args
    # @plan = plan
    mail(to: Rails.application.secrets.email_nupe, subject: "[#{@args[:id]}] Plano de ensino aguardando análise.")
  end

  def enviar_parecer_professor(plan)
    @plan = plan
    mail(from: Rails.application.secrets.email_nupe, to: @plan.user.email, subject: "[#{@plan.id}] Plano de ensino analisado.")
  end
end
