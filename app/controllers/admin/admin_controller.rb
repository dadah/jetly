module Admin
  class AdminController < ApplicationController
    layout "admin"
    helper_method :current_user

    private

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

  end
end
