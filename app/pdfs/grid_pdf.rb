class GridPdf < PdfReport

  TABLE_WIDTHS = [70, 490]
  TABLE_HEADERS = [["Ano/semestre", "Disciplina"]]

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
        # data: {
        #   table_data: table_data,
        #   table_widths: TABLE_WIDTHS
        # }
      },

    )
  end

  def generate options = [header:true, pagination:true, footer:true]
    bounding_box [25, cursor], width: 540 do
      bounding_box [0, cursor], width: 540 do
        repeat :all, :dynamic => true do
          header
          show_pagination
        end
        display_event_table table_data, TABLE_WIDTHS, {header:false}
      end
      footer
    end
    self
  end

  private

  def table_data
    if !@grade.nil? && !@grade.grid_disciplines.empty?
      TABLE_HEADERS +
      @grade.grid_disciplines.order(:year).map do |e|
        [
          e.year.nil? ? e.semestre : e.year,
          "#{e.discipline.sigla} - #{e.discipline.title}"
        ]
      end
    end
  end


end
