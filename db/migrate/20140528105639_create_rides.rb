class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.text :data
      t.timestamps
    end
  end
end
