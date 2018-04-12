class Api::V1::TagsController < Api::V1::BaseController
  before_action :set_page, only: [:index]
  before_action :set_tag, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:create, :update, :destroy]

  def index
    @tags = params['page_number'].present? ? Tag.sorted.paginate(:page => @page_number, :per_page => @page_size) : Tag.sorted
  end

  def show
  end

  def create
    @tag = Tag.new(tags_params)
    @tag.save
  end

  def update
    @tag.update(tags_params)
  end

  def destroy
    @tag.destroy unless @tag.nil?
  end

  private

  def set_tag
    @tag = Tag.find_where_id(params[:id])
  end

  def tags_params
    params.permit(:title)
  end
end
