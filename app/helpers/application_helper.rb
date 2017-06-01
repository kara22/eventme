module ApplicationHelper
# 3 méthodes ajoutés afin de rendre possible le fb login sur la home
# https://stackoverflow.com/questions/27428085/devise-resource-and-resource-name-helpers-in-custom-controller
# http://www.rubydoc.info/github/plataformatec/devise/DeviseController%3Aresource_class

  def resource_name
    :user
  end
  def resource
    @user ||= User.new
  end
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  def resource_class
    devise_mapping.to
  end
end
