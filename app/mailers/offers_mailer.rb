class OffersMailer < ApplicationMailer
  helper :application
  # default template_path: 'devise/mailer'
  add_template_helper EmailHelper
  add_template_helper ApplicationHelper

  def enviar_email_disciplina_ofertada(offer_discipline)
    # @args = args
    @offer_discipline = offer_discipline
    mail(to: @offer_discipline.user.email, subject: "[#{@offer_discipline.id}] A disciplina #{@offer_discipline.discipline.title} foi ofertada para você.")
  end

end
