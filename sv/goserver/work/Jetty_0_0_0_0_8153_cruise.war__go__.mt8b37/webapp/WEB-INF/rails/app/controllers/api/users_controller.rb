class Api::UsersController < Api::ApiController

  def index
    @doc = xml_api_service.write(UsersXmlViewModel.new(user_service.allUsers), "#{request.protocol}#{request.host_with_port}/go")
  end

  def destroy
    render :text => l.string("API_ACCESS_UNAUTHORIZED"), :status => 401 and return unless security_service.isUserAdmin(current_user)
    result = HttpLocalizedOperationResult.new
    user_service.deleteUser(params[:username], result)
    render :status => result.httpCode(), :text => result.message(localizer)
  end

end
