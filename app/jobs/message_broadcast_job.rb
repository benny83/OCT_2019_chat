class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast(
      "conversations-#{message.conversation.id}",
      conversation_id: message.conversation.id,
      message: render_message(message, message.user)
    )
  end

  private

  def render_message(message, user)
    ApplicationController.render(
      partial: 'messages/message',
      locals: { message: message, user: user }
    )
  end
end
