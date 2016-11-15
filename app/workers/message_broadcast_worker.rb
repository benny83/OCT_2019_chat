class MessageBroadcastWorker
  include Sidekiq::Worker

  sidekiq_options retry: false, queue: 'default'

  def perform(msg_id, conversation_id, user_id)
    ActionCable.server.broadcast(
      "conversations-#{conversation_id}",
      conversation_id: conversation_id,
      message: render_message(msg_id, user_id)
    )
  end

  private

  def render_message(msg_id, user_id)
    ApplicationController.render(
      partial: 'messages/message',
      locals: { message: Message.find(msg_id), user: User.find(user_id) }
    )
  end
end