class JetlyUrlsController < ApplicationController

  def index
    @jetly_url = JetlyUrl.new
  end

  def create
    @jetly_url = JetlyUrl.shorten(jetly_url_params[:complete_url]) || JetlyUrl.new
    flash[:error] = 'Invalid url' if @jetly_url.new_record?
    render :index
  end

  def jetly_url_params
    params.require(:jetly_url).permit(:complete_url)
  end

end
