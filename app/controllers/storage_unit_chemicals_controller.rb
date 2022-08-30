class StorageUnitChemicalsController < ApplicationController
  def index
    @storage_unit = StorageUnit.find(params[:id])
    @chemicals = if params[:sort] == 'name'
      @storage_unit.chemicals.order(:name)
    elsif params[:threshold_search]
      @storage_unit.threshold(params[:threshold_search])
    else
      @storage_unit.chemicals
    end
  end
end