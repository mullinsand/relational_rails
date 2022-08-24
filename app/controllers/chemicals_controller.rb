class ChemicalsController < ApplicationController
  def index
    @chemicals = Chemical.all
    @storage_units = StorageUnit.all
  end

  def new
    @storage_units = StorageUnit.all
  end

  def create
    chemical = Chemical.new(
      name: params[:name],
      amount: params[:amount],
      flammable: params[:flammable] == "true" ? true : false,
      storage_unit_id: params[:storage_unit_id]
    )

    chemical.save

    redirect_to '/chemicals'
  end

  def show
    @storage_units = StorageUnit.all
    @chemical = Chemical.find(params[:id])
  end

  def edit

    @all_units = StorageUnit.all.map(&:name)
    @chemical = Chemical.find(params[:id])
    @storage_unit_name = StorageUnit.find(@chemical[:storage_unit_id])[:name]

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
    redirect_to "/chemicals/#{chemical.id}"
  end

  def destory
    Chemical.destroy(params[:id])
    redirect_to '/chemicals'
  end
end