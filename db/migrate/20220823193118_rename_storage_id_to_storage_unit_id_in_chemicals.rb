class RenameStorageIdToStorageUnitIdInChemicals < ActiveRecord::Migration[5.2]
  def up
    rename_column :chemicals, :storage_id, :storage_unit_id
  end

  def down
    rename_column :chemicals, :storage_unit_id, :storage_id
  end
end
