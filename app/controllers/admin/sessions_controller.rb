module Admin
  class SessionsController < AdminController
    def new
    end

    def create
      user = User.find_by(email: params_for_session[:email]).authenticate(params_for_session[:password])
      if user
        session[:user_id] = user.id
        redirect_to admin_jetly_urls_path, :notice => "Logged in!"
      else
        flash.now.alert = "Invalid email or password"
        render "new"
      end
    end

    def destroy
      session[:user_id] = nil
      redirect_to admin_log_in_path, :notice => "Logged out!"
    end

    private

    def params_for_session
      params.permit(:email, :password)
    end

  end
end
