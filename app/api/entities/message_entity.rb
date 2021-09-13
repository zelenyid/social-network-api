module Entities
  class MessageEntity < Grape::Entity
    expose :id, documentation: {
      type: 'Integer',
      desc: 'The unique identifier'
    }

    expose :body, documentation: {
      type: 'String',
      desc: 'Content of the message'
    }

    expose :conversation_id, documentation: {
      type: 'Integer',
      desc: 'ID of the conversation'
    }

    expose :user_id, documentation: {
      type: 'Integer',
      desc: 'ID of the user'
    }

    expose :read, documentation: {
      type: 'Boolean',
      desc: 'Readed?'
    }

    expose :created_at, documentation: {
      type: 'String',
      format: 'date-time',
      desc: 'When the conversation was created'
    }

    expose :updated_at, documentation: {
      type: 'String',
      format: 'date-time',
      desc: 'When the conversation was updated'
    }
  end
end
