class PdfReportOld < Prawn::Document

  # Often-Used Constants

  TABLE_ROW_COLORS = ["FFFFFF","DDDDDD"]
  FONT_SIZE = 10
  TABLE_FONT_SIZE = 9
  PAGE_NUMBER_FONT_SIZE = 8
  TABLE_BORDER_STYLE = :grid

  def initialize(default_prawn_options={})
    super(default_prawn_options)
    font_size FONT_SIZE

    repeat :all, :dynamic => true do
      header
      show_pagination
    end
  end

  def header(title=nil)
    # image "#{Rails.root}/app/assets/images/logo.png", height: 40, align: :left
    # draw_text "#{page_number} / #{page_count}", size: 9, :at => bounds.top_right
    # if title
    #   text title, size: 14, style: :bold_italic, align: :center
    # end
    # bounding_box [bounds.left, bounds.top], :width  => bounds.width do
    #   image "#{Rails.root}/app/assets/images/logo.png", height: 35, align: :left
    #   if title
    #     text title, size: 13, style: :bold, align: :center
    #   end
    #   text "#{page_number} / #{page_count}", size: 9, align: :right
    #   stroke_horizontal_rule
    # end
    # move_down(10)

    bounding_box [bleft, btop], :width => 100 do
      image "#{Rails.root}/app/assets/images/logo.png", height: 40, align: :left
    end
    bounding_box [bleft, btop - 17], :width => 500 do
      text title, size: 12, style: :bold, align: :center
    end

    move_down(10)
    # stroke_horizontal_rule
  end

  def footer
    go_to_page(page_size)
    creation_date = Time.now.strftime('%d/%m/%Y')
    draw_text "Data de geração: " + creation_date, size: PAGE_NUMBER_FONT_SIZE, at: [bounds.left, 0], width: 440
    draw_text "#{page_number} / #{page_count}", size: PAGE_NUMBER_FONT_SIZE, at: [bounds.right - 35, 0], width: 100
  end

  def show_pagination options = {}
    options = {
      at: [bounds.right - 150, -10],
      width: 150,
      size: PAGE_NUMBER_FONT_SIZE,
      style: :normal,
      align: :right,
      start_count_at: 1,
      # page_filter: (1..7),
      # color: '007700'
    }.merge!(options)
    number_pages '<page>/<total>', options
  end

  # MP: def bleft
  # MP: def bright
  # MP: def btop
  # MP: def bbottom
  # MP: def bwidth
  # MP: def bheight
  [:left, :right, :top, :bottom, :width, :height].each do |bounds_meth_type|
    define_method "b#{bounds_meth_type}" do |val = 0|
      bounds.send(bounds_meth_type) + val
    end
  end

end
