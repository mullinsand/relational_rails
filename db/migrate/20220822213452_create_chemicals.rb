class CreateChemicals < ActiveRecord::Migration[5.2]
  def change
    create_table :chemicals do |t|
      t.string :name
      t.float :amount
      t.boolean :flammable
      t.timestamps
    end
  end
end
