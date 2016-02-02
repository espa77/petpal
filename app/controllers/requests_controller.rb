class RequestsController < ApplicationController

  def create
    if current_user.id == params[:friendship][:friend_id].to_i
      flash[:notice] = 'Stop being silly - you cannot add yourself.'
      redirect_to users_index_path
    elsif current_user.friends != [] && current_user.friends.include?(User.find(params[:friendship][:friend_id]))
        flash[:notice] = "You're already friends with them. Hooray!"
        redirect_to users_index_path
    else
      @request = Request.create(:user_id => current_user.id, :friend_id => params[:friendship][:friend_id])
      flash[:notice] = "Friend request sent. Woof."
      redirect_to profile_page_path(current_user)
    end
  end

  def destroy
  end

end
