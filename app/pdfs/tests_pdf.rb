class TestsPdf < PdfReport

  TABLE_ROW_COLORS = ['DDDDDD', 'FFFFFF']
  TABLE_WIDTHS = [20, 120, 300, 40, 60]
  TABLE_HEADERS = [["ID", "Title", "Body", "Active", "Created At"]]

  def initialize(tests=[])
    super()
    @tests = tests
    font_size 9

    header 'Relatório de testes'
    display_event_table
    footer
  end

  private

  def display_event_table
    if table_data.empty?
      text "Nenhum test encontrado"
    else
      table table_data do
        self.header = true
        self.row_colors = TABLE_ROW_COLORS
        self.column_widths = TABLE_WIDTHS
      end
      # table table_data,
      #   headers: TABLE_HEADERS,
      #   column_widths: TABLE_WIDTHS,
      #   row_colors: TABLE_ROW_COLORS,
      #   font_size: TABLE_FONT_SIZE
    end
  end

  def table_data
    TABLE_HEADERS +
    @tests.map do |e|
      [
        e.id,
        e.title,
        e.body,
        e.active? ? 'Ativo' : 'Inativo',
        e.created_at.strftime("%d/%m/%y")
      ]
    end
  end
end
