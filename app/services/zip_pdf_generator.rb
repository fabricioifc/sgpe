# pdf = PlanPdf.new(@plan, current_user).generate
# zip = ZipPdfGenerator.new(@plan, pdf).comprimir
# send_data zip.ler, filename: 'PLANOS_DE_ENSINO.zip'
class ZipPdfGenerator

  def initialize plan, pdf
    @plan = plan
    @filename = "#{@plan.offer_discipline.user.name}_#{@plan.offer_discipline.grid_discipline.discipline.title}.pdf"
    @filename = @filename.gsub!(/( )/, '_').upcase!
    @pdf = pdf
  end

  def comprimir
    @compressed_filestream = Zip::OutputStream.write_buffer do |zos|
      zos.put_next_entry @filename
      zos.print @pdf.render
    end
    self
  end

  def ler
    @compressed_filestream.rewind
    @compressed_filestream.read
  end

end
