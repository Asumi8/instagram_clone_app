class PicturesController < ApplicationController
  before_action :ensure_current_user, only: [:edit, :update, :destroy]

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
    render :new and return if params[:back] #return render:new ガード句
    if @picture.save 
      ConfirmMailer.confirm_mail(@picture).deliver
      redirect_to pictures_path, notice: "投稿しました！確認メールを送信しました！"
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
  
  def ensure_current_user
    @picture = Picture.find(params[:id])
    unless @picture.user_id == current_user.id
      flash[:notice]= "権限がありません"
      redirect_to pictures_path
    end
  end
end
