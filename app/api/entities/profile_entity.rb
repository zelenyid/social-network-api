module Entities
  class ProfileEntity < Grape::Entity
    expose :id, documentation: {
      type: 'Integer',
      desc: 'The unique identifier'
    }

    expose :email, documentation: {
      type: 'String',
      desc: 'Email of the user'
    }

    expose :name, documentation: {
      type: 'String',
      desc: 'Name of the user'
    }

    expose :surname, documentation: {
      type: 'String',
      desc: 'Surname of the user'
    }

    expose :avatar_url, documentation: {
      type: 'String',
      desc: 'Avatar url of the user'
    }

    expose :banned, documentation: {
      type: 'Boolean',
      desc: 'Ban status of the user'
    }

    expose :created_at, documentation: {
      type: 'String',
      format: 'date-time',
      desc: 'When the user was created'
    }

    expose :updated_at, documentation: {
      type: 'String',
      format: 'date-time',
      desc: 'When the user was updated'
    }
  end
end
