class PlanPdf < PdfReport
  include ApplicationHelper

  TABLE_WIDTHS = [70, 470]
  TABLE_HEADERS = [["Ano/semestre", "Componente curricular"]]

  TABLE_WIDTHS_2 = 540

  def initialize(plan, user)
    @plano = plan
    super({
      id: @plano.id,
      title: "Plano de Ensino\n",
      user: user,
      company: {
        name:   Rails.application.secrets.sistema_apelido,
        email:  Rails.application.secrets.admin_email,
        logo:   Rails.root.join("app/assets/images/logo.png")
      },
      font: {
        :normal => Rails.root.join("app/assets/fonts/open-sans/OpenSans-Regular.ttf"),
        :italic => Rails.root.join("app/assets/fonts/open-sans/OpenSans-Italic.ttf"),
        :bold => Rails.root.join("app/assets/fonts/open-sans/OpenSans-Bold.ttf"),
        :bold_italic => Rails.root.join("app/assets/fonts/open-sans/OpenSans-BoldItalic.ttf")
      }
        # data: {
        #   table_data: table_data,
        #   table_widths: TABLE_WIDTHS
        # }
      },

    )
  end

  def generate options = [header:true, pagination:true, footer:true]
    # begin
    #   course_id = @plan.offer_discipline.grid_discipline.grid.course_id
      
    #   coordenador = Coordenador.por_curso(course_id).last
    #   unless coordenador.nil?
    #     @plano.update(coordenador: coordenador)
    #   end
    # rescue Exception => error
    #   message = "Ocorreu um erro interno. Favor entrar em contato com o suporte."
    #   # logger.error message
    #   puts error
    #   # redirect_to root_path, notice: message
    # end
    bounding_box [35, cursor], width: 540 do
      bounding_box [0, cursor], width: 540 do
        repeat :all, :dynamic => true do
          header
          show_pagination
        end

        ano_semestre = @plano.offer_discipline.offer.year.to_s << (
          @plano.offer_discipline.offer.semestre? ? "/#{@plano.offer_discipline.offer.semestre}" : ''
        )

        ultimo_plano_aprovado = get_planos_disciplina_aprovados(@plano.offer_discipline_id).first

        display_event_table(
          table_data(
            [['Curso']],
            [
              "#{@plano.offer_discipline.grid_discipline.grid.course.name}"
            ]
          ),
          [540],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0, columns_bold: [[1,0..0]], columns_background: [1 => [[0, "ffffcc"]]] }
        )

        display_event_table(
          table_data(
            [['Componente Curricular', 'Professor(a)', 'Turma']],
            [
              @plano.offer_discipline.grid_discipline.discipline.title,
              @plano.offer_discipline.decorate.professores,
              "#{@plano.offer_discipline.offer.turma}",
            ]
          ),
          [200, 280, 60],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0, columns_bold: [[1,0..0]], columns_background: [1 => [[0, "ffffcc"]]] }
        )

        display_event_table(
          table_data(
            [['Oferta', 'Modalidade', 'Forma', 'Qtd. Horas', 'Qtd. H/A']],
            [
              "#{ano_semestre} - #{@plano.offer_discipline.offer.decorate.type_offer}",
              @plano.offer_discipline.grid_discipline.grid.course.course_modality.description,
              @plano.offer_discipline.grid_discipline.grid.course.course_format.name,
              @plano.offer_discipline.decorate.carga_horaria_hora_text,
              @plano.offer_discipline.decorate.carga_horaria_aula_text
            ]
          ),
          [144, 126, 132, 69, 69],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )

        distancia = !@plano.offer_discipline.ead_percentual_maximo.nil? &&
              !@plano.offer_discipline.ead_percentual_maximo.eql?(0) &&
              !@plano.ead_percentual_definido.nil?

        if distancia
          horarios = @plano.decorate.carga_horaria_presencial_distancia
          texto_presencial = "Presencial"
          texto_nao_presencial = (('remotas').eql? @plano.offer_discipline.offer.type_offer) ? "Atividades Remotas" : "À Distância"

          display_event_table(
            table_data(
              [['Carga Horária (Hora)', 'Carga Horária (Hora/Aula)']],
              [
                "#{texto_presencial}: #{horarios[:presencial]} - #{texto_nao_presencial}: #{horarios[:distancia]}",
                "#{texto_presencial}: #{horarios[:presencial_aula]} - #{texto_nao_presencial}: #{horarios[:distancia_aula]}"
              ]
            ),
            [270, 270],
            { header:true },
            { borders: [:top, :bottom, :left, :right], borders_length: 0 }
          )
        end

        move_down 10
        bounding_box [bleft, cursor + 5], :width  => TABLE_WIDTHS_2 do
          stroke_color "f2f2f2"
          stroke_horizontal_rule
        end

        display_event_table(
          table_data([['Ementa']], [@plano.offer_discipline.grid_discipline.decorate.ementa(true)]),
          [TABLE_WIDTHS_2],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )
        display_event_table(
          table_data([['Objetivo Geral']], [@plano.offer_discipline.grid_discipline.decorate.objetivo_geral(true)]),
          [TABLE_WIDTHS_2],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )
        display_event_table(
          table_data([['Objetivos Específicos']], [@plano.decorate.obj_espe(true)]),
          [TABLE_WIDTHS_2],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )
        display_event_table(
          table_data([['Conteúdo Programático']], [@plano.decorate.conteudo_prog(true)]),
          [TABLE_WIDTHS_2],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )
        display_event_table(
          table_data([['Práticas Profissionais']], [@plano.decorate.prat_prof(true)]),
          [TABLE_WIDTHS_2],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )
        display_event_table(
          table_data([['Interdisciplinaridade']], [@plano.decorate.interdisc(true)]),
          [TABLE_WIDTHS_2],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )
        display_event_table(
          table_data([['Metodologia: Técnica']], [@plano.decorate.met_tec(true)]),
          [TABLE_WIDTHS_2],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )
        display_event_table(
          table_data([['Metodologia: Recursos']], [@plano.decorate.met_met(true)]),
          [TABLE_WIDTHS_2],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )
        display_event_table(
          table_data([['Sistema de Avaliação e Recuperação']], [@plano.decorate.avaliacao(true)]),
          [TABLE_WIDTHS_2],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )
        display_event_table(
          table_data([['Cronograma de Atividades']], [@plano.decorate.cronograma(true)]),
          [TABLE_WIDTHS_2],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )
        display_event_table(
          table_data([['Referências Básicas']], [@plano.offer_discipline.grid_discipline.decorate.bib_geral(true)]),
          [TABLE_WIDTHS_2],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )
        display_event_table(
          table_data([['Referências Complementares']], [@plano.offer_discipline.grid_discipline.decorate.bib_espec(true)]),
          [TABLE_WIDTHS_2],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )
        display_event_table(
          table_data([['Atendimento ao Aluno']], [@plano.decorate.atendimento(true)]),
          [TABLE_WIDTHS_2],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )
        display_event_table(
          table_data([['Observações']], [@plano.decorate.observacoes(true)]),
          [TABLE_WIDTHS_2],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )

        move_down 10
        bounding_box [bleft, cursor + 5], :width  => TABLE_WIDTHS_2 do
          stroke_color "f2f2f2"
          stroke_horizontal_rule
        end

        observacoes = nil
        if !ultimo_plano_aprovado.nil?
          if !ultimo_plano_aprovado.versao.eql?(@plano.versao)
            observacoes = "A versão #{ultimo_plano_aprovado.versao.to_f} é a última versão aprovada para este plano de ensino."
          end
        end

        display_event_table(
          table_data(
            [['Informações Complementares']],
            [
              "Versão: #{@plano.versao.to_f} - #{@plano.decorate.situacao_texto}"
            ]
          ),
            [TABLE_WIDTHS_2],
            { header:true },
            { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )

        if !observacoes.nil?
          display_event_table(
            table_data(
              [['Observações']],
              [
                observacoes
              ]
            ),
            [TABLE_WIDTHS_2],
            { header:true },
            { borders: [:top, :bottom, :left, :right], borders_length: 0 }
          )
        end

        move_down 10

        # Buscando o coordenador do curso
        course_id = @plano.offer_discipline.grid_discipline.grid.course_id
        coordenador = Coordenador.por_curso(course_id, @plano.created_at.to_date).last
        # binding.pry
        
        professor = @plano.offer_discipline.user.nil? ? nil : ("Professor(a)\n#{@plano.offer_discipline.user.nil? ? "" : @plano.offer_discipline.user.name}\nSiape: #{@plano.offer_discipline.user.nil? ? "" : @plano.offer_discipline.user.siape}")
        # Segundo professor, caso exista
        professor2 = @plano.offer_discipline.second_user.nil? ? nil : ("Professor(a)\n#{@plano.offer_discipline.second_user.nil? ? "" : @plano.offer_discipline.second_user.name}\nSiape: #{@plano.offer_discipline.second_user.nil? ? "" : @plano.offer_discipline.second_user.siape}")
        coordenador_texto = coordenador.nil? ? nil : "#{coordenador.funcao}\n#{coordenador.user.name}\nSiape: #{coordenador.user.siape}"
        parecer_user = @plano.user_parecer.nil? ? nil : "#{@plano.user_parecer.name}\nSiape: #{@plano.user_parecer.siape}"

        case 
          when !professor.nil? && !professor2.nil? && !coordenador.nil?
            simple_table [
              "\n\n\n#{"_"*30}\n#{professor}",
              "\n\n\n#{"_"*30}\n#{professor2}",
              "\n\n\n#{"_"*30}\n#{coordenador_texto}",
              ], [180,180,180]  
          when !professor.nil? && !professor2.nil? && coordenador_texto.nil?
            simple_table [
              "\n\n\n#{"_"*46}\n#{professor}",
              "\n\n\n#{"_"*46}\n#{professor2}",
              ], [270, 270]
          when !professor.nil? && !coordenador_texto.nil?
            simple_table [
              "\n\n\n#{"_"*46}\n#{professor}",
              "\n\n\n#{"_"*46}\n#{coordenador_texto}",
              ], [270, 270] 
          when !professor2.nil? && !coordenador_texto.nil?
            simple_table [
              "\n\n\n#{"_"*46}\n#{professor2}",
              "\n\n\n#{"_"*46}\n#{coordenador_texto}",
              ], [270, 270]
          when !professor.nil?
            simple_table [
              "\n\n\n#{"_"*95}\n#{professor}",
              ], [540]
          when !professor2.nil?
            simple_table [
              "\n\n\n#{"_"*95}\n#{professor2}",
              ], [540]
        end
  
        # Se foi analisado
        unless parecer_user.nil?
          move_down 10
          simple_table [
            "\n\n\n#{"_"*95}\nResponsável pela Conferência\n#{parecer_user}",
          ], [540]
        end

      end

      # Adiciona informações adicionais ao final da página de cada plano
      footer(page_number)

      # Inicia uma nova página para cada novo plano do lote
      # if index + 1 != @plano.count
      #   start_new_page
      # end
    end
    self
  end

  private

  def table_data table_header, values = []
    table_header +
      [
        values.each do |e|
          e
        end
      ]
  end

  def simple_table rows, cols_width
    tabela = make_table([rows],
      :header => false,
      :cell_style => { size: 10 },
      :column_widths => cols_width
    )
    tabela.draw
  end


end
