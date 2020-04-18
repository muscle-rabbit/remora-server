class Twitter::UsersController < Twitter::BaseController
  def index 
    vars = request.query_parameters
    response = {:status => :bad_request, :message => "query missing"}

    if validate_query(vars)
      begin
        response[:status] = :ok
        response[:message] = @client.user_search(vars[:q])
      rescue Twitter::Error::Unauthorized => e
        response[:status] = :unauthorized
        response[:message] = e.message
      end
    end

    render :json => response
  end
end

def validate_query(query)
  validated = true
  must_include = ["q"]

  query.each do |key, value|
    must_include.each do |item|
      if key == item
        return validated
      end
    end
  end
  
  return !validated
end