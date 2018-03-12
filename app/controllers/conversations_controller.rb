class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @conversations = Conversation.all
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
    convo_html = partial_to_string(Conversation.find(params[:conversationId]))
    # @conversation = Conversation.find(params[:conversationId])
    render json: { 
        loaded_convo: convo_html
      }, 
      status: 200
  end

  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
 
  def partial_to_string(conversation)
    render_to_string(
      partial: 'conversations/conversation_thread', 
      layout: false, 
      formats: [:html], 
      locals: { conversation_thread: conversation}
    )
  end
end