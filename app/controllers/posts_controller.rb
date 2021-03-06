class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like]
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all.select {|post| post.favorite_id == nil}
    if Post.all.length>0
      @random_post = Post.all[rand(0..(Post.all.length-1))]
    end

  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = set_post
    @comments = @post.comments
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json

  def create
    @post = Post.new(post_params)
      if params[:favorite_id]
      @post.favorite_id = params[:favorite_id]
    end
    @post.user_id = current_user.id
    respond_to do |format|
      if @post.save
        if @post.favorite_id != nil
          format.html { redirect_to "/favorites/#{@post.favorite_id}", notice: 'Post was successfully created.' }
        else
            # @post.attachments(@post.user_id,params[:attachment]) if params[:attachment]
          format.html { redirect_to @post, notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @post }
        end
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def like
    @post = Post.find(params[:id])
    @post.liked_by current_user
    respond_to do |format|
      format.js { }
      format.html { redirect_to @post }
    end
  end

  def unlike
    @post = Post.find(params[:id])
    @post.downvote_by current_user
    respond_to do |format|
      format.js { }
      format.html { redirect_to @post }
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:attachment, :content, :user_id, :favorite_id)
    end
end
