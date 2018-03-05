class Api::V1::RegionsController < Api::V1::BaseController
  before_action :set_page, only: [:index]
  before_action :set_region, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user # , except: [:create, :update]

  def index
    @regions = params['page_number'].present? ? Region.sorted.paginate(:page => @page_number, :per_page => @page_size) : Region.sorted
  end

  def show
  end

  def create
    @region = Region.new(regions_params)
    @region.save
  end

  def update
    @region.update(regions_params)
  end

  def destroy
    @region.destroy unless @region.nil?
  end

  private

  def set_region
    @region = Region.find_where_id(params[:id])
  end

  def regions_params
    params.permit(:country_name, :city_name, :location, :currency_symbol)
  end
end
