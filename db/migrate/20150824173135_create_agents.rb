class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :extension
      t.string :phone_number

      t.timestamps
    end
  end
end
