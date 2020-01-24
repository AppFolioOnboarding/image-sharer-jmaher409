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
      flash[:success] = 'You have successfully added an image.'
      redirect_to @image
    else
      render :new
    end
  end

  def show
    @image = Image.find_by id: params[:id]
    redirect_to new_image_path if @image.nil?
  end

  def destroy
    @image = Image.find_by delete_params

    if @image
      @image.destroy
      flash[:success] = 'You have successfully deleted the image.'
    end

    redirect_to images_path
  end

  private

  def create_params
    params.require(:image).permit(:url, :tag_list)
  end

  def index_params
    params.permit(:tag)
  end

  def delete_params
    params.permit(:id)
  end
end
