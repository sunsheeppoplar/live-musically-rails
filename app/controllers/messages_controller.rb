class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    @messages = @conversation.messages

    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end

    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end

    if @messages.last
      if @messages.last.user_id != current_user.id
        @messages.last.read = true;
      end
    end

    @message = @conversation.messages.new
  end

  def new
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)
    if @message.save
      ActionCable.server.broadcast "conversations:#{@conversation.id}",
        conversation_id: @conversation.id,
        message: @message.body,
        user: @message.user.email
      redirect_to conversation_messages_path(@conversation)
    end
  end

  def ajax_create
    @message = @conversation.messages.new(message_params)
    if @message.save
      ActionCable.server.broadcast "conversations:#{@conversation.id}",
        conversation_id: @conversation.id,
        message: @message.body,
        user: current_user.email

        render json: { did_it_work: "yes" }, status: 200
    end
  end

  private
    def message_params
      params[:message][:user_id] = current_user.id
      params.require(:message).permit(:body, :user_id)
    end
  end