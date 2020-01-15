class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    @image = Image.new(params.require(:image).permit(:url))
    if @image.save
      redirect_to @image, notice: 'Image saved successfully.'
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @image = Image.find_by id: params[:id]
    redirect_to new_image_path if @image.nil?
  end
end
