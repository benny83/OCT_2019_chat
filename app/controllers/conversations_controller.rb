class ConversationsController < ApplicationController
  def index
    @conversations = Conversation.all
  end

  def new
    if request.referrer.split("/").last == "chatrooms"
      flash[:notice] = nil
    end
    @conversation = Conversation.new
  end

  def create
    @conversation = Conversation.new(chatroom_params)
    if @conversation.save
      respond_to do |format|
        format.html { redirect_to conversation_path(@conversation) }
        format.js
      end
    else
      respond_to do |format|
        flash[:error] = '123123'
        format.html { redirect_to new_conversation_path, flash: {
          error: 'A room with this topic already exists'
        } }
      end
    end
  end

  def show
    @conversation = Conversation.find(params[:id])
    @message = Message.new
  end

  # def create
  #   binding.pry
  #   @conversation = Conversation.get(current_user.id, params[:user_id])

  #   add_to_conversations unless conversated?

  #   respond_to do |format|
  #     format.js
  #   end
  # end

  # def close
  #   @conversation = Conversation.find(params[:id])

  #   session[:conversations].delete(@conversation.id)

  #   respond_to do |format|
  #     format.js
  #   end
  # end

  private

  def chatroom_params
    params.require(:conversation).permit(:topic)
  end

  def add_to_conversations
    session[:conversations] ||= []
    session[:conversations] << @conversation.id
  end

  def conversated?
    session[:conversations].include?(@conversation.id)
  end
end
