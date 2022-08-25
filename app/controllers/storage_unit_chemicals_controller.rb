class StorageUnitChemicalsController < ApplicationController
  def index
    @storage_unit = StorageUnit.find(params[:id])
    @chemicals = if params[:sort] == 'name'
      @storage_unit.chemicals.order(:name)
    elsif params[:threshold_search]
      @storage_unit.chemicals.select { |chemical| chemical.amount > params[:threshold_search].to_f}
    else
      @storage_unit.chemicals
    end
  end
end