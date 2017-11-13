class PdfReport < Prawn::Document
  attr_reader :attributes, :id, :company, :custom_font, :logo, :message

  TABLE_ROW_COLORS = ["FFFFFF","F5F5F5"]
  FONT_SIZE = 10
  TABLE_FONT_SIZE = 9
  PAGE_NUMBER_FONT_SIZE = 8

  def initialize(attributes)
    @attributes   = attributes
    @id           = attributes.fetch(:id)
    @company      = attributes.fetch(:company)
    @custom_font  = attributes.fetch(:font, {})
    @user         = attributes.fetch(:user, nil)
    # @table_data   = attributes.fetch(:data).fetch(:table_data)
    # @table_widths = attributes.fetch(:data).fetch(:table_widths)

    super(margin: attributes.fetch(:margin, [70,0,50,0]))

    setup_fonts if custom_font.any?
    generate
  end

  private


    def setup_fonts
      font_families.update "Primary" => custom_font
      font "Primary"
    end

    def header
      if company.has_key? :logo
        bounding_box [bleft + 20, btop + 50], :width => 100 do
          image open(company.fetch(:logo)), height: 32, align: :left
        end
      elsif company.has_key? :name
        bounding_box [bleft + 25, btop + 40], :width => 100 do
          text "#{company.fetch(:name)}", size: 14, style: :bold, align: :left
        end
      end

      # move_down 8
      # text "<color rgb='a6a6a6'>RECEIPT FOR CHARGE ##{id}</color>", inline_format: true
      bounding_box [bleft + 50, btop + 40], :width => 520 do
        text "#{attributes.fetch(:title)}", size: 14, style: :bold, align: :center
      end

      move_down 20
      bounding_box [bleft + 25, btop + 10], :width  => 560 do
        stroke_color "f2f2f2"
        stroke_horizontal_rule
      end
    end

    def footer
      go_to_page(page_count)
      creation_date = Time.now.strftime('%d/%m/%Y')
      canvas do
        bounding_box [bleft + 25, bbottom + 25], :width  => 510 do
          detalhes = "Data de geração: " + creation_date
          detalhes = detalhes + ", gerado por #{attributes.fetch(:user).name}" unless attributes.fetch(:user).nil?
          draw_text detalhes, size: PAGE_NUMBER_FONT_SIZE, at: [bleft, bbottom]
          draw_text "Páginas: #{page_count}", size: PAGE_NUMBER_FONT_SIZE, at: [bright, bbottom]
        end
      end
      # creation_date = Time.now.strftime('%d/%m/%Y')
      # draw_text "Data de geração: " + creation_date, size: PAGE_NUMBER_FONT_SIZE, at: [bleft, bbottom]
    end

    def show_pagination options = {}
      options = {
        at: [bright - 80, btop + 40],
        width: 50,
        size: PAGE_NUMBER_FONT_SIZE,
        # style: :normal,
        align: :right,
        start_count_at: 1,
        # color: '222222'
      }.merge!(options)
      number_pages '<page>/<total>', options
    end

    def display_event_table table_data = [], table_widths = []
      @table_data   = table_data
      @table_widths = table_widths

      if !@table_data.empty?
        borders = @table_data.length - 2
        # move_down 90

        table @table_data,
          column_widths: @table_widths,
          cell_style: { border_color: 'cccccc', size: TABLE_FONT_SIZE },
          width: @table_widths.sum do
            self.header = true
            self.row_colors = TABLE_ROW_COLORS
            cells.padding = 4
            cells.borders = []
            row(0).font_style = :bold
            row(0).background_color = "f5f5f5"
            row(0..borders).borders = [:bottom]
        end
      end
    end

    # MP: def bleft, MP: def bright, MP: def btop
    # MP: def bbottom, MP: def bwidth, MP: def bheight
    [:left, :right, :top, :bottom, :width, :height].each do |bounds_meth_type|
      define_method "b#{bounds_meth_type}" do |val = 0|
        bounds.send(bounds_meth_type) + val
      end
    end
end
