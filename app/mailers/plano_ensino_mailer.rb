class PlanoEnsinoMailer < ApplicationMailer
  helper :application
  # default template_path: 'devise/mailer'
  add_template_helper EmailHelper
  add_template_helper ApplicationHelper

  def enviar_aviso_nupe(plan)
    # @args = args
    @plan = plan
    mail(to: Rails.application.secrets.email_nupe, subject: "[#{@plan.id}] Plano de ensino aguardando análise.")
  end

  def enviar_parecer_professor(plan)
    @plan = plan
    from =  Rails.application.secrets.email_nupe
    to =    @plan.user.email
    # to =    'fabricio.bizotto@ifc.edu.br'

    mail(from: from, to: to, subject: "[#{@plan.id}] Plano de ensino analisado.")
  end

  # Enviar um aviso ao professor para que crie/finalize o plano de ensino
  # Geralmente será utilizado pelo coordenador
  def enviar_aviso_plano_pendente from, offer_discipline
    @offer_discipline = offer_discipline
    to =    @offer_discipline.user.email

    mail(from: from, to: to, subject: "[#{@offer_discipline.grid_discipline.discipline.decorate.title}] Plano de ensino pendente.")
  end
end
