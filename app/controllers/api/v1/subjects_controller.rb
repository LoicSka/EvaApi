class Api::V1::SubjectsController < Api::V1::BaseController
  before_action :set_page, only: [:index]
  before_action :set_subject, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:create, :update, :destroy]

  def index
    @subjects = params['page_number'].present? ? Subject.sorted.paginate(:page => @page_number, :per_page => @page_size) : Subject.sorted
  end

  def show
  end

  def create
    @subject = Subject.new(subjects_params)
    @subject.save
  end

  def update
    @subject.update(subjects_params)
  end

  def destroy
    @subject.destroy unless @subject.nil?
  end

  private

  def set_subject
    @subject = Subject.find_where_id(params[:id])
  end

  def subjects_params
    params.permit(:title)
  end
end
