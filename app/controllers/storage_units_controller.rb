class StorageUnitsController < ApplicationController
  def index
    @storage_units_sorted =
    if params[:sort]
      StorageUnit.sort_by_chemicals
    elsif params[:search_exact]
      StorageUnit.search_exact(params[:search_exact])
    elsif params[:search_partial]
      StorageUnit.search_partial(params[:search_partial])
    else
      StorageUnit.sort_by_creation
    end
  end

  def new

  end

  def create
    storage_unit = StorageUnit.new(storage_unit_params)

    storage_unit.save

    redirect_to '/storage_units'
  end



  def to_boolean(string)
    ActiveRecord::Type::Boolean.new.cast(string)
  end

  def show
    @storage_unit = StorageUnit.find(params[:id])
  end

  def edit
    @storage_unit = StorageUnit.find(params[:id])
  end

  def update
    storage_unit = StorageUnit.find(params[:id])
    storage_unit.update(storage_unit_params)
    storage_unit.save
    redirect_to "/storage_units/#{storage_unit.id}"
  end

  def destroy
    StorageUnit.destroy(params[:id])
    redirect_to '/storage_units'
  end

  private
  def storage_unit_params
    params[:fireproof] = to_boolean(params[:fireproof])
    params.permit(:name, :size, :fireproof)
  end
end