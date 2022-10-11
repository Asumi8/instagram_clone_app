class PicturesController < ApplicationController

  def index 
    @pictures = Picture.all
  end

  def new 
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def create
    @picture = current_user.pictures.build(picture_params) #ログインしているユーザのpicturesメソッドをbuild
    render :new and return if params[:back]
    if @picture.save 
      redirect_to pictures_path, notice: "投稿しました！"
    else
      render :new
    end
  end

  def show
    @picture = Picture.find(params[:id])
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def edit 
    @picture = Picture.find(params[:id])
  end

  def update
    @picture = Picture.find(params[:id])
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "投稿を編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to pictures_path
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  private 

  def picture_params
    params.require(:picture).permit(:content, :image, :image_cache)
  end
end
