class PostsController < ApplicationController
  before_action :set_ogp, only: [:show]

  def index
    @posts = Post.includes(:user)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    Rails.logger.info "post_params: #{post_params.inspect}"

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
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    redirect_to posts_path, success: "投稿を削除しました", status: :see_other
  end

    private

  def post_params
    params.require(:post).permit(:title, :body, :post_image, :post_image_cache)
  end

  def set_ogp
    @post = Post.find(params[:id])
    @ogp = {
      title: @post.title,
      description: @post.body.truncate(100),
      image: @post.post_image.url || asset_path("default-ogp.png"),
      url: request.original_url
    }
  end
end
