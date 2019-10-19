# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ConversationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conversations-#{current_user.id}"
    # stream_from 'messages'
  end

  def unsubscribed
    stop_all_streams
  end

  # def receive(payload)
  #   binding.pry
  #   Message.create(user: current_user, chatroom_id: payload["chatroom_id"], content: payload["message"])
  # end

  def speak(data)
    message_params = data['message'].each_with_object({}) do |el, hash|
      hash[el.values.first] = el.values.last
    end

    Message.create(message_params)

    # ActionCable.server.broadcast(
    #   "conversations-#{current_user.id}",
    #   message: message_params
    # )
  end
end
