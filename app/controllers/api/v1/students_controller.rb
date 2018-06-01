class Api::V1::StudentsController < Api::V1::BaseController
  before_action :set_page, only: [:index]
  before_action :set_student, only: [:show, :update, :destroy]
  def index
    @students = @users = params['page_number'].present? ? Student.sorted.paginate(:page => @page_number, :per_page => @page_size) : Student.sorted
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
    @user = Student.find_where_id(params[:id])
  end

  def student_params
    params.permit(:full_name, :gender, :region_id, :subject_id, days_available: [], criteria_attributes: [:type, values: []])
  end

end
