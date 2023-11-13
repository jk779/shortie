class Fu
  rlsController < ApplicationController
  def show

  end

  def create
    @url = Url.new(url_params)
    if @url.save
      redirect_to @url
    else
      render 'new'
    end
  end

  private

  def url_params
    params.require(:url).permit(:original_url, :short_url)
  end
end
