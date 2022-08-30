class StorageUnitChemicalsController < ApplicationController
  def index
    @storage_unit = StorageUnit.find(params[:id])
    @chemicals = if params[:sort] == 'name'
        @storage_unit.chemicals.order(:name)
      elsif params[:threshold_search]
        @storage_unit.threshold(params[:threshold_search])
      elsif params[:search_exact]
          Chemical.flammable_chemicals.search_exact(params[:search_exact])
      elsif params[:search_partial]
        Chemical.flammable_chemicals.search_partial(params[:search_partial])
      else
        @storage_unit.chemicals
      end
  end
end