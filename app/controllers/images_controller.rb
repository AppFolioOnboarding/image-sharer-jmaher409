class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def index
    @view_model = ImagesView.new
  end

  def create
    @image = Image.new(params.require(:image).permit(:url))
    tag_list = params.require(:image).permit(:tag_list)[:tag_list]
    @image.tag_list.add(tag_list, parse: true)

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
