class DatatablesGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :model, type: :string
  class_option :doc, type: :boolean, default: true, desc: "Include documentation."

  def generate_init
    generate_application_datatable
  end

  def generate_model
    generate_model_datatable unless model == 'init'
  end

  private

  def generate_application_datatable
    copy_file 'datatable_template.template', 'app/datatables/application_datatable.rb'
  end

  def generate_model_datatable
    template 'model_datatable_template.template', "app/datatables/#{model.underscore}_datatable.rb"
  end
end
