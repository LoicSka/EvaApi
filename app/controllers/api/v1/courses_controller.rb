class Api::V1::CoursesController < Api::V1::BaseController

  before_action :set_page, only: [:index]
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_user , except: [:create, :update]

  def index
    @courses = params['page_number'].present? ? Course.sorted.paginate(:page => @page_number, :per_page => @page_size) : Course.sorted
    @courses = params['tutor_account_id'].present? ? @courses.where(tutor_account_id: params['tutor_account_id']) : @courses
  end

  def show

  end

  def create
    @course = Course.new(courses_params)
    @course.save
  end

  def update
    @course.update(courses_params)
  end

  def destroy
    @course.destroy unless @course.nil?
  end

  private

  def set_course
    @course = Course.find_where_id(params[:id])
  end

  def courses_params
    params.permit(:teaching_experience, :expertise, :title, :age_group, :subject, :tutor_account_id, :description, :hourly_rate, tag_ids: [])
  end

end
