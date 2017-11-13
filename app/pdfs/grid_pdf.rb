class GridPdf < PdfReport

  TABLE_WIDTHS = [50, 510]
  TABLE_HEADERS = [["Ano", "Disciplina"]]

  def initialize(grid, user)
    @grade = grid
    super({
      id: grid.id,
      title: 'Grade de Cursos',
      user: user,
        company: {
          name:   Rails.application.secrets.sistema_apelido,
          email:  Rails.application.secrets.admin_email,
          logo:   Rails.root.join("app/assets/images/logo.png")
        },
        data: {
          table_data: table_data,
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
    end
  end

  def generate
    bounding_box [25, cursor], width: 540 do
      bounding_box [0, cursor], width: 540 do
        repeat :all, :dynamic => true do
          header
          show_pagination
        end
        display_event_table table_data, TABLE_WIDTHS
      end
      footer
    end
  end

end
