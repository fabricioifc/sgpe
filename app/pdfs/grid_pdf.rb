class GridPdf < PdfReport

  TABLE_WIDTHS = [50, 490] # Tamanho total: 540
  TABLE_HEADERS = [["Ano", "Disciplina"]]

  def initialize(grid)
    @grade = grid
    super({
      id: grid.id,
      product: 'IFC',
      title: 'Grade de Cursos',
        company: {
          name: "IFC",
          address: "37 Great Jones\nFloor 2\nNew York City, NY 10012",
          email: "teachers@onemonth.com",
          logo: Rails.root.join("app/assets/images/logo.png")
        },
        data: {
          table_data: table_data + table_data + table_data,
          table_widths: TABLE_WIDTHS
        }
      },

    )
  end

  private

  def table_data
    if !@grade.nil? && !@grade.grid_disciplines.empty?
      TABLE_HEADERS +
      @grade.grid_disciplines.order(:year).map do |e|
        [
          e.year,
          "#{e.discipline.sigla} - #{e.discipline.title}"
        ]
      end
    else
      []
    end
  end

end
