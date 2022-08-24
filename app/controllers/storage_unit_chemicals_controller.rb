class StorageUnitChemicalsController < ApplicationController
  def index
    @storage_unit = StorageUnit.find(params[:id])
    @chemicals = @storage_unit.chemicals.order(params[:sort])
  end
end