class PostsController < ApplicationController
  skip_before_action :authenticate_admin!, only: [:show, :index]
  before_action :set_post, only: %i[ edit update destroy ]

  # GET /posts or /posts.json
  def index
  @posts = Post.order(created_at: :desc).page(params[:page]).per(3)
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Seu post foi criado com sucesso!." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Seu post foi atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    comments = Comment.where(post_id: @post.id) # select comments that is from the current post
    comments.destroy_all
    @post.destroy
    redirect_to root_path
    #respond_to do |format|
    #format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
    #format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:tittle, :content, :image, :admin_id)
    end
end
