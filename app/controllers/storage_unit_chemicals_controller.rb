class StorageUnitChemicalsController < ApplicationController
  def index
    require 'pry'; binding.pry
    @storage_unit = StorageUnit.find(params[:id])
    @chemicals = if params[:sort] == 'name'
      @storage_unit.chemicals.order(:name)
    else
      @storage_unit.chemicals
    end
  end
end