class Api::V1::BaseController < ApplicationController
  include ActionController::ImplicitRender
  def set_page
    @page_size = params['page_size'].present? ? params['page_size'].to_i : 25
    @page_number = params['page_number'].present? ? params['page_number'].to_i : 1
    response.set_header('Next', @page_number.to_i + 1)
  end
end