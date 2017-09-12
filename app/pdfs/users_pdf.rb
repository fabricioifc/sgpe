class UsersPdf < PdfReport

  TABLE_ROW_COLORS = ['FFFFFF', 'DDDDDD']
  TABLE_WIDTHS = [30, 140, 140, 130, 40, 60] # Tamanho total: 540
  TABLE_HEADERS = [["ID", "Nome", "Usuário", "E-mail", "Admin", "Dt. Cadastro"]]

  def initialize(users=[])
    super()
    @users = users
    font_size 9

    header 'Lista de usuários'
    move_down(10)
    display_event_table
    footer
  end

  private

  def display_event_table
    if table_data.empty?
      text "Nenhum usuário encontrado"
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
    @users.map do |e|
      [
        e.id,
        e.name,
        e.username,
        e.email,
        e.admin? ? 'Sim' : 'Não',
        e.created_at.strftime("%d/%m/%y")
      ]
    end
  end
end
