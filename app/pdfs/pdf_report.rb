class PdfReport < Prawn::Document

  # Often-Used Constants

  TABLE_ROW_COLORS = ["FFFFFF","DDDDDD"]
  FONT_SIZE = 10
  TABLE_FONT_SIZE = 9
  TABLE_BORDER_STYLE = :grid

  def initialize(default_prawn_options={})
    super(default_prawn_options)
    font_size FONT_SIZE
  end

  def header(title=nil)
    # image "#{Rails.root}/app/assets/images/logo.png", height: 40, align: :left
    # draw_text "#{page_number} / #{page_count}", size: 9, :at => bounds.top_right
    # if title
    #   text title, size: 14, style: :bold_italic, align: :center
    # end
    bounding_box [bounds.left, bounds.top], :width  => bounds.width do
      image "#{Rails.root}/app/assets/images/logo.png", height: 40, align: :left
      if title
        text title, size: 13, style: :bold, align: :center
      end
      stroke_horizontal_rule
    end
  end

  def footer
    creation_date = Time.now.strftime('%d/%m/%Y')
    draw_text "Data de geração: " + creation_date, size: 9, at: [0,0]
    draw_text "#{page_number} / #{page_count}", size: 9, :at => [500,0]

  end

  # ... More helpers

end
