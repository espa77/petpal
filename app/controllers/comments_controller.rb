class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable, only: [:create]
  respond_to :js

  def create
    @comment = @commentable.comments.new do |message|
      message.comment = params[:comment_text]
      message.user = current_user
    end
    @comment.save
    respond_to do |format|
      format.html {redirect_to root_path}
      format.js { }
    end
  end

  def like
    @comment = Comment.find(params[:id])
    if @comment.liked_by current_user
      respond_to do |format|
        format.js {render 'comments/like.js.erb'}
        format.html { redirect_to :back }
      end
    end
  end

  # def like
  #   @post = Post.find(params[:id])
  #   @post.liked_by current_user
  #   redirect_to @post
  # end

  def unlike
    @comment = Comment.find(params[:id])
    if @comment.downvote_by current_user
      respond_to do |format|
        format.js {render 'comments/unlike.js.erb'}
        format.html { redirect_to :back }
      end
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @commentable = @comment.commentable_type.constantize.find(@comment.commentable_id)
    @comment_id = params[:id]
    @comment.destroy
      respond_to do |format|
        format.js { render 'comments/destroy.js.erb'}
        format.html {redirect_to root_path}
    end
  end

  def update
  end

  private

  def find_commentable
    @commentable_type = params[:commentable_type].classify
      if params[:commentable_id] != nil || params.include?(:post_id) == false
        @commentable = @commentable_type.constantize.find(params[:commentable_id])
      else
        @commentable = @commentable_type.constantize.find(params[:post_id])
      end
    end
end
