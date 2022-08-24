class StorageUnitChemicalsController < ApplicationController
  def index
    @storage_unit = StorageUnit.find(params[:id])
    @chemicals = if params[:sort_by] == 'name'
      @chemicals.order(:name)
    else
      @storage_unit.chemicals
    end
  end
end