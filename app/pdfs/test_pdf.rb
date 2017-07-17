class TestPdf < Prawn::Document

  def initialize(test)
   super(top_margin: 70)
   @test = test
  #  @view = view
   test_number
   line_items
 end

 def test_number
   text "Teste \##{@test.id}", size: 30, style: :bold
 end

 def line_items
   move_down 20
   table line_item_rows do
     row(0).font_style = :bold
     columns(2..3).align = :left
     self.row_colors = ['DDDDDD', 'FFFFFF']
     self.header = true
   end
 end

 def line_item_rows
   linha = [["Título", "Conteúdo", "Ativo"]]
   if @test.is_a?(Array)
     @test.map do |item|
       linha << [item.title, item.body, status(item.active)]
     end
   else
     linha << [@test.title, @test.body, status]
   end
 end

 private

 def status
   @test.active? ? 'Ativo' : 'Inativo'
  #  @view.number_to_currency(n)
 end

end
