module Admin
  class UsersController < AdminController
    def new
      @user = User.new
    end

    def create
      @user = User.new(params_for_users)
      if @user.save
        redirect_to admin_jetly_urls_path, :notice => "Signed up!"
      else
        render :new
      end
    end

    private

    def params_for_users
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

  end
end
