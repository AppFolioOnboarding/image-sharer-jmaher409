class ImagesController < ApplicationController

  def new; end

  def show
    @image_url = Image.find(params[:id]).url
    print '@image ', @image
  end

  def create
    render plain: params[:url].inspect
    #@image = Image.new(create_image_params)
    #@image.save
    #
    #redirect_to @image, notice: 'Image created successfully' if @image.valid?
  end

  private

  def create_image_params
    params.permit(:url)
  end

end

