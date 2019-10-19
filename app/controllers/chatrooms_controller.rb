class ChatroomsController < ApplicationController
  def index
    @chatroom = Conversation.new
    @chatrooms = Conversation.all
  end

  def new
    if request.referrer.split("/").last == "chatrooms"
      flash[:notice] = nil
    end
    @chatroom = Conversation.new
  end

  def edit
    @chatroom = Conversation.find_by(slug: params[:slug])
  end

  def create
    @chatroom = Conversation.new(chatroom_params)
    if @chatroom.save
      respond_to do |format|
        format.html { redirect_to @chatroom }
        format.js
      end
    else
      respond_to do |format|
        flash[:notice] = {error: ["a chatroom with this topic already exists"]}
        format.html { redirect_to new_chatroom_path }
        format.js { render template: 'chatrooms/chatroom_error.js.erb'} 
      end
    end
  end

  def update
    chatroom = Conversation.find_by(slug: params[:slug])
    chatroom.update(chatroom_params)
    redirect_to chatroom
  end

  def show
    @chatroom = Conversation.find_by(slug: params[:slug])
    @message = Message.new
  end

  private

  def chatroom_params
    params.require(:chatroom).permit(:topic)
  end
end