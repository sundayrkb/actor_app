class CreateActors < ActiveRecord::Migration[7.0]
  def change
    create_table :actors do |t|
      t.string :name
      t.integer :age
      t.float :height
      t.float :rating

      t.timestamps
    end
  end
end
