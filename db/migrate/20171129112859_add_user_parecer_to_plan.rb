class AddUserParecerToPlan < ActiveRecord::Migration[5.1]
  def change
    add_reference :plans, :user_parecer, index:true
  end
end
