require 'will_paginate/array'
class Api::V1::TutorAccountsController < Api::V1::BaseController
  before_action :set_page, only: [:index]
  before_action :set_tutor_account, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user , only: [:create, :update]

  def index
    if params['age_group'].present? || params['subject'].present? || params['price_range'].present? || params['region'].present? || params['available_days'].present?
       @tutor_accounts = TutorAccount.filter_with(age_group: params['age_group'].to_i, subject: params['subject'], price_range: params['price_range'].present? ? (params['price_range'][0].to_f..params['price_range'][1].to_f) : nil, region: params['region'], available_days: params['available_days'].present? ? params['available_days'] : []).paginate(:page => @page_number, :per_page => @page_size)
    else
      @tutor_accounts = params['page_number'].present? ? TutorAccount.sorted.paginate(:page => @page_number, :per_page => @page_size) : TutorAccount.sorted
    end
  end
  
  def show
  end

  def create
    @tutor_account = TutorAccount.new(tutor_accounts_params)
    @tutor_account.save
  end

  def update
    @tutor_account.update(tutor_accounts_params)
  end

  def destroy
    @tutor_account.destroy unless @tutor_account.nil?
  end

  private

  def set_tutor_account
    @tutor_account = TutorAccount.find_where_id(params[:id])
  end

  def tutor_accounts_params
    params.permit(:title)
  end
end
