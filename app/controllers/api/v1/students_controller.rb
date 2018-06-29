class Api::V1::StudentsController < Api::V1::BaseController
  before_action :set_page, only: [:index]
  before_action :set_filters, only: [:index]
  before_action :set_student, only: [:show, :update, :destroy]
  
  def index
    @students = params['page_number'].present? ? @filtred_students.paginate(:page => @page_number, :per_page => @page_size) : @filtred_students
  end

  # GET /students/1
  def show
  end

  def create
    @student = Student.new(student_params)
    @student.save
  end

  def update
    @student.update(student_params)
  end

  def destroy
    @student.destroy unless @student.nil?
  end

  private
  def set_student
    @student = Student.find_where_id(params[:id])
  end

  def set_filters
    @filtred_students = params[:user_id].present? ? Student.where(user_id: params[:user_id]) : Student.sorted
  end

  def student_params
    params.permit(:full_name, :gender, :region_id, :subject_id, :user_id, :age_group, days_available: [], criteria_attributes: [:type, values: []])
  end

end
