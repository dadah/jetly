module Admin
  class JetlyUrlsController < AdminController
    before_filter :ensure_current_user_present

    def index
      @jetlies = JetlyUrl.page(params[:page]).order('visits_count DESC')
    end

    private

    def ensure_current_user_present
      return if current_user.present?
      redirect_to admin_log_in_path, notice: 'Please log in'
    end

  end
end
