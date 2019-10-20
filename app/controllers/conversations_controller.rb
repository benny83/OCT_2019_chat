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
    @conversation = Conversation.new(conversation_params)
    @conversation.save(validate: false)

    respond_to do |format|
      format.html { redirect_to conversation_path(@conversation) }
      format.js
    end
  end

  def private
    conversation = Conversation.find(params[:conversation_id])
    if conversation.authenticate(params[:password])
      render :show, locals: { conversation: conversation }
    else
      redirect_to root_path
    end
  end

  def show
    conversation = Conversation.find(params[:id])
    if conversation.password_digest && params[:password].blank?
      redirect_to root_path
    else
      render :show, locals: { conversation: conversation }
    end

    # respond_to do |format|
    #   format.html
    #   format.js
    # end
  end

  private

  def conversation_params
    params.require(:conversation).permit(:topic, :password)
  end
end
