class Twitter::TimelineController < Twitter::BaseController
  def index
    vars = request.query_parameters
    response = {:status => :bad_request, :message => "query missing"}

    if validate_query(vars)
      begin
        response[:status] = :ok
        response[:message] = @client.user_timeline(vars[:screen_name])
      rescue
        response[:status] = :bad_request
        response[:message] = "not found"
      end
    end

    render :json => response
  end
end

def validate_query(query)
  validated = true
  must_include = ["user_id", "screen_name"]

  query.each do |key, value|
    must_include.each do |item|
      if key == item
        return validated
      end
    end
  end
  
  return !validated
end