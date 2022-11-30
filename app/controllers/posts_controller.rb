class PostsController < ApplicationController
  include SuggestedUsers
  before_action :set_suggested_users, only: %i[index]
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all.order(id: :desc)
  end

  # GET /posts/1 or /posts/1.json
  def show
    @comment = Comment.new
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params.merge(created_by: current_user))

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_path(@post), notice: "Post foi criado com sucesso." }
      else
        flash.now[alert:] = "deu ruim parceiro"
        render :new
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:body, :photo, :likes)
    end
end
