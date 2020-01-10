class ImagesController < ApplicationController

  def add_image_form; end

  def show
    @image_url = Image.find(params[:id]).url
    print '@image ', @image
  end

  def create
    print params[:url]

    #return nil unless valid_url(url)

    @image = Image.new(create_image_params)
    @image.save

    redirect_to @image
  end

  private

  def show_image_params
    params.permit(:id, :url)
  end

  def create_image_params
    params.permit(:url)
  end

  def valid_url(url)
    parsed = URI.parse(url)
    print 'parsed', parsed
    parsed.is_a?(URI: HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    print 'invalid url: ', url
    false
  end
end

