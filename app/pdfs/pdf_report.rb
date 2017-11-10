class PdfReport < Prawn::Document
  attr_reader :attributes, :id, :company, :custom_font, :line_items, :logo, :message, :product

  TABLE_ROW_COLORS = ["FFFFFF","F5F5F5"]
  FONT_SIZE = 10
  TABLE_FONT_SIZE = 9
  PAGE_NUMBER_FONT_SIZE = 8

  def initialize(attributes)
    @attributes   = attributes
    @id           = attributes.fetch(:id)
    @company      = attributes.fetch(:company)
    @line_items   = attributes.fetch(:line_items) { nil }
    @custom_font  = attributes.fetch(:font, {})
    @message      = attributes.fetch(:message) { default_message }
    @table_data   = attributes.fetch(:data).fetch(:table_data)
    @table_widths = attributes.fetch(:data).fetch(:table_widths)

    super(margin: 0)

    setup_fonts if custom_font.any?
    generate
  end

  private

    def default_message
      "Relatório vazio."
      # "We've received your payment for #{attributes.fetch(:product)}. You can keep this receipt for your records. For questions, contact us anytime at <color rgb='326d92'><link href='mailto:#{company.fetch(:email)}?subject=Charge ##{id}'><b>#{company.fetch(:email)}</b></link></color>."
    end

    def setup_fonts
      font_families.update "Primary" => custom_font
      font "Primary"
    end

    def header
      if company.has_key? :logo
        bounding_box [bleft + 20, btop - 20], :width => 100 do
          image open(company.fetch(:logo)), height: 32, align: :left
        end
      else
        move_down 32
      end

      # move_down 8
      # text "<color rgb='a6a6a6'>RECEIPT FOR CHARGE ##{id}</color>", inline_format: true
      bounding_box [bleft + 50, btop - 30], :width => 520 do
        text "#{attributes.fetch(:title)}", size: 14, style: :bold, align: :center
      end

      move_down 20
      bounding_box [bleft + 25, btop - 60], :width  => 560 do
        stroke_color "f2f2f2"
        stroke_horizontal_rule
      end
      # text message, inline_format: true, size: 12.5, leading: 4
    end

    def footer
      go_to_page(page_count)
      creation_date = Time.now.strftime('%d/%m/%Y')
      draw_text "Data de geração: " + creation_date, size: PAGE_NUMBER_FONT_SIZE, at: [bleft, bbottom]
      draw_text "#{page_number} / #{page_count}", size: PAGE_NUMBER_FONT_SIZE, at: [bright, bbottom]
    end

    # MP: def bleft, MP: def bright, MP: def btop
    # MP: def bbottom, MP: def bwidth, MP: def bheight
    [:left, :right, :top, :bottom, :width, :height].each do |bounds_meth_type|
      define_method "b#{bounds_meth_type}" do |val = 0|
        bounds.send(bounds_meth_type) + val
      end
    end

    def show_pagination options = {}
      options = {
        at: [bright - 80, btop - 30],
        width: 50,
        size: PAGE_NUMBER_FONT_SIZE,
        style: :normal,
        align: :right,
        start_count_at: 1,
        # color: '007700'
      }.merge!(options)
      number_pages '<page>/<total>', options
    end

    def display_event_table
      if !@table_data.empty?
        borders = @table_data.length - 2
        move_down 90

        table @table_data, cell_style: { border_color: 'cccccc', size: 10 }, width: 560 do
          self.header = true
          self.row_colors = TABLE_ROW_COLORS
          column_widths = @table_widths
          cells.padding = 4
          cells.borders = []
          row(0).font_style = :bold
          row(0).background_color = "f5f5f5"
          row(0..borders).borders = [:bottom]
        end

      end
    end

    def generate
      bounding_box [25, 792], width: 540, height: 770 do
        bounding_box [0, 792], width: 540, height: 750 do
          repeat :all, :dynamic => true do
            header
            show_pagination
          end
          display_event_table
        end
        footer
      end
    end

end
