class StorageUnitsController < ApplicationController
  def index
    @storage_units_sorted = StorageUnit.sort_by_creation
  end

  def new

  end

  def create
    storage_unit = StorageUnit.new({
      name: params[:name],
      size: params[:size],
      fireproof: params[:fireproof] == "true" ? true : false
    })

    storage_unit.save

    redirect_to '/storage_units'
  end

  def storage_unit_params
    params.permit(:name, :size, :fireproof)
  end

  def show
    @storage_unit = StorageUnit.find(params[:id])
  end

  def edit
    @storage_unit = StorageUnit.find(params[:id])
  end

  def update
    storage_unit = StorageUnit.find(params[:id])
    storage_unit.update({
      name: params[:name],
      size: params[:size],
      fireproof: params[:fireproof] == "true" ? true : false
    })
    storage_unit.save
    redirect_to "/storage_units/#{storage_unit.id}"
  end

  def destory
    StorageUnit.destroy(params[:id])
    redirect_to '/storage_units'
  end
end