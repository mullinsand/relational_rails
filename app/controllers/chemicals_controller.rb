class ChemicalsController < ApplicationController
  def index
    @chemicals = 
      if params[:search_exact]
        Chemical.flammable_chemicals.search_exact(params[:search_exact])
      elsif params[:search_partial]
        Chemical.flammable_chemicals.search_partial(params[:search_partial])
      else
        Chemical.flammable_chemicals
      end
    @storage_units = StorageUnit.all
  end

  def new
    @storage_unit_options_array = StorageUnit.build_options_array
    @storage_unit_name = 
      if params[:id]
        [StorageUnit.find(params[:id])[:name], StorageUnit.find(params[:id])[:id]]
      else
        [StorageUnit.first[:name], StorageUnit.first[:id]]
      end
  end

  def create
    chemical = Chemical.new(chemical_params)

    chemical.save

    redirect_to "/storage_units/#{chemical.storage_unit_id}/chemicals"
  end
  
  def show
    @storage_units = StorageUnit.all
    @chemical = Chemical.find(params[:id])
  end

  def edit

    @storage_unit_options_array = StorageUnit.build_options_array
    @chemical = Chemical.find(params[:id])
    @storage_unit_name = [StorageUnit.find(@chemical[:storage_unit_id])[:name], StorageUnit.find(@chemical[:storage_unit_id])[:id]]

  end

  def update
    chemical = Chemical.find(params[:id])
    chemical.update(chemical_params)
    chemical.save
    redirect_to "/chemicals/#{params[:id]}"
  end

  def destroy
    Chemical.destroy(params[:id])
    redirect_to '/chemicals'
  end

  private
  def chemical_params
    params[:flammable] = to_boolean(params[:flammable])
    params.permit(:name, :amount, :flammable, :storage_unit_id)
  end
end