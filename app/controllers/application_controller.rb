class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  
  layout proc {
    if request.xhr?
      false
    else
      "application"
    end
  }
end
