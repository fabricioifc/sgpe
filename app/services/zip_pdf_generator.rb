# pdf = PlanPdf.new(@plan, current_user).generate
# zip = ZipPdfGenerator.new(@plan, pdf).comprimir
# send_data zip.ler, filename: 'PLANOS_DE_ENSINO.zip'
class ZipPdfGenerator

  def initialize lista_planos
    @lista = lista_planos
  end

  def comprimir
    @compressed_filestream = Zip::OutputStream.write_buffer do |zos|
      @lista.each do |plano, x|
        @plan = plano[:plano]
        @pdf = plano[:pdf]
        @filename = "#{@plan.offer_discipline.user.name}_#{@plan.offer_discipline.grid_discipline.discipline.title}"
        @filename = @filename.gsub!(/( )/, '_').upcase! + ".pdf"

        zos.put_next_entry @filename
        zos.print @pdf.render
      end
    end
    self
  end

  def ler
    @compressed_filestream.rewind
    @compressed_filestream.read
  end

end
