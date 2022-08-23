class AddForeignKeyValueToStorageUnitId < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :chemicals, :storage_units
  end
end
