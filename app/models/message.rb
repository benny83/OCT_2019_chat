class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  # after_create_commit { MessageBroadcastJob.perform_later(self) }

  after_create_commit { MessageBroadcastWorker.perform_async(id, conversation.id, user.id) }
end
