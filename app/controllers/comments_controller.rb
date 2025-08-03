class CommentsController < ApplicationController

def create
  @prototype = Prototype.find(params[:prototype_id])
  @comment = @prototype.comments.new(comment_params)

    if @comment.save
      redirect_to prototype_path(@prototype)
      #保存成功 → トップヘージへ
    else
      @comments = @prototype.comments.includes(:user)
      #保存失敗 → 画面再表示
      render "prototypes/show", status: :unprocessable_entity
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id)
  end

end
