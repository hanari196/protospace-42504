class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except:[:index, :show]
  before_action :redirect_unless_owner, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.all.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
      #保存成功 → トップヘージへ
    else
      #保存失敗 → 画面再表示
      render :new
    end
  end

  def show
    @comment = Comment.new                          #新規ｺﾒﾝﾄ投稿用のﾌｫｰﾑで使用する空のｺﾒﾝﾄｲﾝｽﾀﾝｽを作成
    @comments = @prototype.comments.includes(:user) #該当prototypeに紐づく全てのｺﾒﾝﾄを取得
  end

  def edit
  end

 def update
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end
  end

def destroy
    if @prototype.user == current_user
       @prototype.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  #投稿者以外はﾄｯﾌﾟﾍﾟｰｼﾞへﾘﾀﾞｲﾚｸﾄ
  def redirect_unless_owner
    unless current_user == @prototype.user
      redirect_to root_path
    end
  end
end
