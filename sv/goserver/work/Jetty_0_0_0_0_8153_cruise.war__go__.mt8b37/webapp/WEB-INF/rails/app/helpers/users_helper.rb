module UsersHelper
  def user_search_model_to_array(model)
    user = model.getUser()
    "['#{user.getName}', '#{user.getDisplayName.gsub(/[']/, '\\\\\'')}', '#{user.getEmail}']"
  end
end