class FriendshipsController < ApplicationController
 
  def create
    if current_user.id == params[:friendship][:friend_id].to_i
      flash[:notice] = 'Cannot add yourself.'
      redirect_to profile_page_path(current_user)
    elsif current_user.friends != [] && current_user.my_friends.include?(User.find(params[:friendship][:friend_id]))
        flash[:notice] = "Unable to add friend."
        redirect_to users_index_path
    else
      @friendship = current_user.friendships.build(:friend_id => params[:friendship][:friend_id])
      if @friendship.save
        #binding.pry
        @request = Request.find(params[:friendship][:request_id])
        @request.destroy
        flash[:notice] = "Added friend."
        redirect_to profile_page_path(current_user)
      end
    end
  end

  def show
  end

  def destroy
    #binding.pry
    @friendship = Friendship.all.find(params[:friendship_id])
    @friend_id = Friendship.all.find(params[:friendship_id]).friend_id
    @friendship.destroy
    respond_to do |format|
      format.js { render 'friendships/destroy.js.erb'}
      format.html { }
    end
  end

end
