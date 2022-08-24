class ChemicalsController < ApplicationController
  def index
    @chemicals = Chemical.all
    @storage_units = StorageUnit.all
  end

  def new
    @storage_units = StorageUnit.all
    @storage_unit_name = [StorageUnit.find(params[:id])[:name], StorageUnit.find(params[:id])[:id]]
  end

  def create
    chemical = Chemical.new(
      name: params[:name],
      amount: params[:amount],
      flammable: params[:flammable] == "true" ? true : false,
      storage_unit_id: params[:storage_unit_id]
    )

    chemical.save

    redirect_to "/storage_units/#{chemical.storage_unit_id}/chemicals"
  end

  def show
    @storage_units = StorageUnit.all
    @chemical = Chemical.find(params[:id])
  end

  def edit

    @all_units = StorageUnit.all.map(&:name).zip(StorageUnit.all.map(&:id))
    @chemical = Chemical.find(params[:id])
    @storage_unit_name = [StorageUnit.find(@chemical[:storage_unit_id])[:name], StorageUnit.find(@chemical[:storage_unit_id])[:id]]

  end

  def update
    chemical = Chemical.find(params[:id])
    chemical.update({
      name: params[:name],
      amount: params[:amount],
      flammable: params[:flammable] == "true" ? true : false,
      storage_unit_id: params[:storage_unit_id]
    })
    chemical.save
    redirect_to "/chemicals/#{params[:id]}"
  end

  def destory
    Chemical.destroy(params[:id])
    redirect_to '/chemicals'
  end
end