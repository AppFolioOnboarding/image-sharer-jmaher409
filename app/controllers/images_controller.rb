class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def index
    @view_model = ImagesView.new(index_params[:tag])
  end

  def create
    created_params = create_params
    @image = Image.new(url: created_params[:url])

    tag_list = created_params[:tag_list]

    @image.tag_list.add(tag_list, parse: true)

    if @image.save
      redirect_to @image, notice: 'You have successfully added an image.'
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @image = Image.find_by id: params[:id]
    redirect_to new_image_path if @image.nil?
  end

  private

  def create_params
    params.require(:image).permit(:url, :tag_list)
  end

  def index_params
    params.permit(:tag)
  end
end
