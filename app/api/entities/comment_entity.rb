module Entities
  class CommentEntity < Grape::Entity
    expose :id, documentation: {
      type: 'Integer',
      desc: 'The unique identifier'
    }

    expose :content, documentation: {
      type: 'String',
      desc: 'Content of the comment'
    }

    expose :post_id, documentation: {
      type: 'Integer',
      desc: 'ID of the post'
    }

    expose :user_id, documentation: {
      type: 'Integer',
      desc: 'ID of the author of the comment'
    }

    expose :created_at, documentation: {
      type: 'String',
      format: 'date-time',
      desc: 'When the post was created'
    }

    expose :updated_at, documentation: {
      type: 'String',
      format: 'date-time',
      desc: 'When the post was updated'
    }
  end
end
