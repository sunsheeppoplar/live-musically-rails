class ConversationsChannel < ApplicationCable::Channel
  def subscribed
    current_user.included_conversations.each do |conversation|
      stream_from "conversations:#{conversation.id}"
    end
  end

  def unsubscribed
    stop_all_streams
  end
end