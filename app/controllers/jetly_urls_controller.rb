class JetlyUrlsController < ApplicationController

  def index
    @jetly_url = JetlyUrl.new
  end

  def create
    @jetly_url = JetlyUrl.find_by(jetly_url_params) || JetlyUrl.create(jetly_url_params)
    flash[:error] = 'Invalid url' if @jetly_url.errors.any?
    render :index
  end

  def jetly_url_params
    params.require(:jetly_url).permit(:complete_url)
  end

end
