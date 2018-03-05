class ApplicationController < ActionController::API; include ActionView::Rendering
  # Knock jwt authentication
  include Knock::Authenticable

  # a decent date time format... ;)
  def format_time(str)
    arr = str.strip.split("-")
    begin
      return Time.new(arr[0].to_i, arr[1].to_i, arr[2].to_i)
    rescue
      return Time.now
    end
  end

  def add_allow_credentials_headers
    response.headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
    response.headers['Access-Control-Allow-Credentials'] = 'true'
  end

  def unauthorized_entity(entity_name)
    render 'api/unauthorized'
  end

  def options
    head :status => 200, :'Access-Control-Allow-Headers' => 'accept, content-type'
  end

end
