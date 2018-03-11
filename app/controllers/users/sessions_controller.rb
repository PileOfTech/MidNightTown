class Users::SessionsController < Devise::SessionsController
  skip_before_action :require_no_authentication, :only => [ :new, :create]
  skip_before_action :verify_authenticity_token
  
  def new
    if user_signed_in?
      redirect_to root_path
    end
  end

  def create
    if user = User.find_for_authentication(email: params[:email])
      if user.valid_password?(params[:password])
        sign_in user
        res = {msg: 'succes', success: true}
        status_code = 200
      else
        res = {error: 'error', success: false}
        status_code = 400
      end
    else
      res = {error: 'error', success: false}
      status_code = 400
    end
    render json: res, status: status_code  
  end


  def destroy
    user = current_user
    sign_out user
    redirect_to root_path
  end
end
