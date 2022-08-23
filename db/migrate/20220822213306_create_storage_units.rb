class CreateStorageUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :storage_units do |t|
      t.string :name
      t.float :size
      t.boolean :fireproof

      t.timestamps
    end
  end
end
