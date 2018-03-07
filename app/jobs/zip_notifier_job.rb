require 'open-uri'

class ZipNotifierJob < ApplicationJob
  include PlansHelper
  queue_as :default

  def perform(offer, user)
    #
    # planos = []
    # offer.offer_disciplines.each do |od|
    #   plano_oferta = ultimo_plano_por_disciplina(od.id)
    #   if !plano_oferta.nil?
    #     pdf = PlanPdf.new(plano_oferta, user).generate
    #     planos << [plano: plano_oferta, pdf: pdf]
    #   end
    # end
    # zip = ZipPdfGenerator.new(planos).comprimir
    #
    # send_data zip.ler, filename: 'PLANOS_DE_ENSINO.zip'
  end
end
