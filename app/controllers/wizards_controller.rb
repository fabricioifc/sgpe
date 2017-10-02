class WizardsController < ApplicationController

  before_action :load_offer_wizard, except: %i(validate_step)

  def validate_step
    current_step = params[:current_step]

    @offer_wizard = wizard_offer_for_step(current_step)
    @offer_wizard.offer.attributes = offer_wizard_params
    session[:offer_attributes] = @offer_wizard.offer.attributes

    if @offer_wizard.valid?
      next_step = wizard_offer_next_step(current_step)
      create and return unless next_step

      redirect_to action: next_step
    else
      render current_step
    end
  end

  def create
    if @offer_wizard.offer.save
      session[:offer_attributes] = nil
      redirect_to root_path, notice: 'Offer succesfully created!'
    else
      redirect_to({ action: Wizard::Offer::STEPS.first }, alert: 'There were a problem when creating the offer.')
    end
  end

  private

  def load_offer_wizard
    @offer_wizard = wizard_offer_for_step(action_name)

    case params[:action]
    when 'step1'
      @grades = Grid.includes(:course).
        joins(:grid_disciplines => :discipline).
        order('grid_disciplines.year', 'grid_disciplines.semestre').
        pluck('id', 'grid_disciplines.year', 'grid_disciplines.semestre', 'courses.name', 'year').uniq
    when 'step2'
      @anos = Grid.joins(:grid_disciplines => :discipline).
        where('grids.id = ? AND grid_disciplines.year is not null', @offer_wizard.grid_id).
        order('grid_disciplines.year').
        pluck('grid_disciplines.year').uniq
      @semestres = Grid.joins(:grid_disciplines => :discipline).
        where('grids.id = ? AND grid_disciplines.semestre is not null', @offer_wizard.grid_id).
        order('grid_disciplines.semestre').
        pluck('grid_disciplines.semestre').uniq
      when 'step3'
        if !@offer_wizard.grid_year.nil?
          @grid_disciplinas = GridDiscipline.joins(:grid).where('grids.id = ? and grid_disciplines.year = ?', @offer_wizard.grid_id, @offer_wizard.grid_year)
        else
          @grid_disciplinas = GridDiscipline.joins(:grid).where('grids.id = ? and grid_disciplines.semestre = ?', @offer_wizard.grid_id, @offer_wizard.grid_semestre)
        end
        @offer_wizard.offer.offer_disciplines.build
    end

  end

  def wizard_offer_next_step(step)
    Wizard::Offer::STEPS[Wizard::Offer::STEPS.index(step) + 1]
  end

  def wizard_offer_for_step(step)
    raise InvalidStep unless step.in?(Wizard::Offer::STEPS)

    "Wizard::Offer::#{step.camelize}".constantize.new(session[:offer_attributes])
  end

  def offer_wizard_params
    params.require(:offer_wizard).permit(:grid_id, :grid_year, :grid_semestre)
  end

  class InvalidStep < StandardError; end

  # include Wicked::Wizard
  #
  # steps :grid_picker, :grid_year_picker, :grid_disciplines_picker
  #
  # # attr_accessor :grid_id
  #
  # def show
  #   session[:offer_wizard] ||= {}
  #
  #   @offer = WizardOffer.new(session[:offer_wizard][:offer])
  #   @step = step
  #   @grades = Grid.includes(:course).
  #     joins(:grid_disciplines => :discipline).
  #     order('grid_disciplines.year', 'grid_disciplines.semestre').
  #     pluck('id', 'grid_disciplines.year', 'grid_disciplines.semestre', 'courses.name', 'year').uniq
  #
  #   render_wizard
  # end
  #
  # def new
  #   offer = WizardOffer.new
  #
  #   session[:offer_wizard] ||= {}
  #   session[:offer_wizard][:offer] = offer.accessible_attributes
  #
  #   redirect_to wizard_path(steps.first)
  # end
  #
  # def update
  #   binding.pry
  #   @offer = WizardOffer.new(session[:offer_wizard][:offer])
  #   @offer.attributes = offer_params
  #
  #   @offer.step = step
  #   @offer.steps = steps
  #   @offer.session = session
  #   @offer.validations = validations
  #
  #   render_wizard @offer
  # end
  #
  # private
  #
  # def validations
  #   {
  #     grid_picker: [:grid_id, :year],
  #     grid_year_picker: [:grid_id, :year],
  #     grid_disciplines_picker: [:grid_id, :year]
  #   }
  # end
  #
  # def offer_params
  #   params.require(:offer).permit(:grid_id, :year)
  # end

end
