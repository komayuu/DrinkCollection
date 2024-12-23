class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    if @post.nil?
      flash[:aleat] = "お探しの投稿はありません"
      redirect_to posts_path
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), success: "投稿を更新しました"
    else
      flash.now[:danger] = "更新出来ませんでした"
      render :edit, status: :unprocessable_entity
    end

    def destroy
      post = current_user.posts.find(params[:id])
      post.destroy!
      redirect_to posts_path, success: "投稿を削除しました", status: :see_other
    end
  end

    private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
