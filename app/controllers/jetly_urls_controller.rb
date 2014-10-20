class JetlyUrlsController < ApplicationController

  def index
    @jetly_url = JetlyUrl.new
  end

  def create
    @jetly_url = JetlyUrl.find_by(jetly_url_params) || JetlyUrl.create(jetly_url_params)
    flash[:error] = 'Invalid url' if @jetly_url.errors.any?
    render :index
  end

  def show
    if jetly_url = JetlyUrl.find_by(url_hash: params[:id]).presence
      jetly_url.increment_visits
      redirect_to jetly_url.complete_url
    else
      flash[:error] = 'Unknown URL'
      redirect_to jetly_urls_path
    end
  end

  def jetly_url_params
    params.require(:jetly_url).permit(:complete_url)
  end

end
