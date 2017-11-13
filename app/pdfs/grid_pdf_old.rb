class GridPdfOld < PdfReport

  TABLE_ROW_COLORS = ['FFFFFF', 'DDDDDD']
  TABLE_WIDTHS = [30, 510] # Tamanho total: 540
  TABLE_HEADERS = [["Ano", "Disciplina"]]

  TABLE_WIDTHS_EMENTA = [540]
  TABLE_HEADERS_EMENTA = [["Disciplina"]]

  def initialize(grid)
    super()
    @grade = grid
    # font_size 9

    header "Grade: #{@grade.id} - Ano: #{@grade.year}"
    display_event_table
    footer

  end

  private

  def box_content(string)
    text string
    transparent(0.5) { stroke_bounds }
  end

  def display_event_table
    if @grade.grid_disciplines.empty?
      text "Nenhuma disciplina encontrada"
    else
      # indent(10) do
      #   text "Some indentation inside an indent block."
      # end
      width = 540
      indent_size = 10
      pad_size = 10
      # @grade.grid_disciplines.order(:year).map do |e|
      #   bounding_box([0, cursor], :width => width, :height => cursor) do
      #     transparent(0.5) { stroke_bounds }
      #     indent(indent_size) do
      #       pad(pad_size) {
      #         text "No indentation inside this bounding box."
      #         indent(40) do
      #           text "Inside an indent block. And so is this horizontal line:"
      #           stroke_horizontal_rule
      #         end
      #
      #         move_down 10
      #         text "No indentation"
      #         move_down 20
      #
      #         text "Another indent block."
      #         bounding_box([0, cursor], :width => width - indent_size * 2) do
      #           text "Note that this bounding box coordinates are relative to the " +
      #           "indent block"
      #           transparent(0.5) { stroke_bounds }
      #         end
      #       }
      #     end
      #   end
      # end
    end
  end

  # def display_event_table
  #   if table_data.empty?
  #     text "Nenhuma disciplina encontrada"
  #   else
  #     table table_data do
  #       self.header = true
  #       self.row_colors = TABLE_ROW_COLORS
  #       self.column_widths = TABLE_WIDTHS
  #     end
  #   end
  # end

  # def table_data
  #   TABLE_HEADERS +
  #   @grade.grid_disciplines.order(:year).map do |e|
  #     [
  #       e.year,
  #       "#{e.discipline.sigla} - #{e.discipline.title}"
  #     ]
  #   end
  # end

end
