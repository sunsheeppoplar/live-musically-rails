class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    # @conversations = Conversation.all
    @conversations = current_user.included_conversations
  end
  
  def create
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    redirect_to conversation_messages_path(@conversation)
  end

  def load_conversation
    # convo_html = partial_to_string(Conversation.find(params[:conversationId]).messages)
    last_ten_messages_html = partial_to_string(Conversation.find(params[:conversationId]).messages.last(10))
    render json: { 
        loaded_convo: last_ten_messages_html
    }, status: 200
  end

  def load_new_message
    message_html = partial_to_string([Conversation.find(params[:conversationId]).messages.last])
    render json: {
      loaded_message: message_html
    }, status: 200
  end

  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
 
  def partial_to_string(message_set)
    render_to_string(
      partial: 'conversations/conversation_thread', 
      layout: false, 
      formats: [:html], 
      locals: { message_set: message_set}
    )
  end
end