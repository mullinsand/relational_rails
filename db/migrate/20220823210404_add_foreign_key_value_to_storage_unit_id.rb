class AddForeignKeyValueToStorageUnitId < ActiveRecord::Migration[5.2]
  def change
    add_reference :chemicals, :storage_unit, foreign_key: true
  end
end
