class ConversationsController < ApplicationController
  def index
    render :index, locals: { conversations: Conversation.all }
  end

  def new
    render :new, locals: { conversation: Conversation.new }
  end

  def create
    conversation = Conversation.new(conversation_params)
    conversation.save(validate: false)

    respond_to do |format|
      format.html { redirect_to conversations_path, flash: {
        success: "Successful created #{conversation.topic}"
      } }
      format.js
    end
  end

  def private
    conversation = Conversation.find(params[:conversation_id])
    if conversation.authenticate(params[:password])
      render :show, locals: { conversation: conversation }
    else
      redirect_to conversations_path, flash: { error: "Invalid password, pes" }
    end
  end

  def show
    conversation = Conversation.find(params[:id])
    if conversation.password_digest && params[:password].blank?
      redirect_to conversations_path, flash: { error: "Private room, pes" }
    else
      render :show, locals: { conversation: conversation }
    end
  end

  private

  def conversation_params
    params.require(:conversation).permit(:topic, :password)
  end
end
