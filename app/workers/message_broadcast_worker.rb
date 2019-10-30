class MessageBroadcastWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  sidekiq_options retry: false, queue: 'default'

  def perform(msg_id, conversation_id, user_id)
    notification = "STATUS: #{Sidekiq::Status.status(jid)} #{DateTime.now.to_s} #{self.class} JID-#{jid} INFO: start"
    logger.info(notification)

    ActionCable.server.broadcast(
      "conversations-#{conversation_id}",
      conversation_id: conversation_id,
      message: render_message(msg_id, user_id),
      notification: notification,
      jid: jid
    )
    logger.info("MessageBroadcastWorker JID-#{jid} INFO: done")
    # (::Process.clock_gettime(::Process::CLOCK_MONOTONIC) - start).round(3)} sec")
  end

  private

  def render_message(msg_id, user_id)
    ApplicationController.render(
      partial: 'messages/message',
      locals: { message: Message.find(msg_id), user: User.find(user_id) }
    )
  end
end