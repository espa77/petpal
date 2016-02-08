class RequestsController < ApplicationController
 
  def create
    if current_user.id == params[:friend_id].to_i
      flash[:notice] = 'Stop being silly - you cannot add yourself.'
      redirect_to users_index_path
    elsif current_user.friends != [] && current_user.my_friends.include?(User.find(params[:friend_id]))
        flash[:notice] = "You're already friends with them. Hooray!"
        redirect_to users_index_path
    elsif Request.find_by(:user_id => current_user.id, :friend_id => params[:friend_id]) != nil
        redirect_to users_index_path
    else
      @request = Request.create(:user_id => current_user.id, :friend_id => params[:friend_id])
        respond_to do |format|
        format.js { }
        format.html { redirect_to users_index_path }
      end
    end
  end

  def destroy
    @request = Request.find(params[:id])
    @request.destroy
    respond_to do |format|
      format.js { render 'requests/destroy.js.erb'}
      format.html { }
    end
  end

end
