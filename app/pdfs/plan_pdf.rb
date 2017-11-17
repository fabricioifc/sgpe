class PlanPdf < PdfReport

  TABLE_WIDTHS = [70, 490]
  TABLE_HEADERS = [["Ano/semestre", "Disciplina"]]

  def initialize(plan, user)
    @plano = plan
    super({
      id: plan.id,
      title: 'Plano de ensino',
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

        ano_semestre = @plano.offer_discipline.grid_discipline.year? ? @plano.offer_discipline.grid_discipline.year : @plano.offer_discipline.grid_discipline.semestre

        display_event_table(
          table_data(
            [['Componente curricular', 'Professor']],
            [
              @plano.offer_discipline.grid_discipline.discipline.title,
              @plano.offer_discipline.user.name,
            ]
          ),
          [280, 280],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0, columns_bold: [[1,0..0]], columns_background: [1 => [[0, "ffffcc"]]] }
        )

        display_event_table(
          table_data(
            [['Turma', 'Forma', 'Qtd. Horas', 'Qtd. H/A']],
            [
              "#{@plano.turma.year}.#{ano_semestre}.#{@plano.offer_discipline.grid_discipline.grid.course.sigla}.#{@plano.turma.name}",
              @plano.offer_discipline.grid_discipline.grid.course.course_format.name,
              @plano.offer_discipline.grid_discipline.carga_horaria,
              @plano.offer_discipline.grid_discipline.decorate.carga_horaria_aula
            ]
          ),
          [180, 180, 100, 100],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )

        move_down 10
        bounding_box [bleft, cursor + 5], :width  => 560 do
          stroke_color "f2f2f2"
          stroke_horizontal_rule
        end

        display_event_table(
          table_data([['Ementa']], [@plano.offer_discipline.grid_discipline.ementa]),
          [560],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )
        display_event_table(
          table_data([['Objetivo Geral']], [@plano.offer_discipline.grid_discipline.objetivo_geral]),
          [560],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )
        display_event_table(
          table_data([['Objetivos Específicos']], [@plano.obj_espe]),
          [560],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )
        display_event_table(
          table_data([['Conteúdo programático']], [@plano.conteudo_prog]),
          [560],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )
        display_event_table(
          table_data([['Práticas profissionais']], [@plano.prat_prof]),
          [560],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )
        display_event_table(
          table_data([['Interdisciplinariedade']], [@plano.interdisc]),
          [560],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )
        display_event_table(
          table_data([['Metodologia Técnica']], [@plano.met_tec]),
          [560],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )
        display_event_table(
          table_data([['Recursos metodológicos']], [@plano.met_met]),
          [560],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )
        display_event_table(
          table_data([['Sistema de avaliação e recuperação']], [@plano.avaliacao]),
          [560],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )
        display_event_table(
          table_data([['Cronograma de atividades']], [@plano.cronograma]),
          [560],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )
        display_event_table(
          table_data([['Bibliografia Básica']], [@plano.offer_discipline.grid_discipline.bib_geral]),
          [560],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )
        display_event_table(
          table_data([['Bibliografia Complementar']], [@plano.offer_discipline.grid_discipline.bib_espec]),
          [560],
          { header:true },
          { borders: [:top, :bottom, :left, :right], borders_length: 0 }
        )
      end
      footer
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


end
