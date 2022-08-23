class ChemicalsController < ApplicationController
  def index
    @chemicals = Chemical.all
  end

  def new
    @storage_units = StorageUnit.all
  end

  def create
require 'pry'; binding.pry
    chemical = Chemical.new(
      name: params[:name],
      amount: params[:amount],
      flammable: params[:flammable] == "true" ? true : false,
      storage_id: params[:storage_id]
    )

    chemical.save

    redirect_to '/chemicals'
  end

  def show
    @chemical = Chemical.find(params[:id])
  end

  def edit
    @chemical = Chemical.find(params[:id])
  end

  def update
    chemical = Chemical.find(params[:id])
    chemical.update({
      name: params[:chemical][:name],
      amount: params[:chemical][:amount],
      flammable: params[:chemical][:flammable] == "true" ? true : false
    })
    chemical.save
    redirect_to "/chemicals/#{chemical.id}"
  end

  def destory
    Chemical.destroy(params[:id])
    redirect_to '/chemicals'
  end
end