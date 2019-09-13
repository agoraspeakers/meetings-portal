# frozen_string_literal: true

# Users roles module
module UsersRoles
  # Custom role exception
  class RoleException < StandardError
    def initialize(message)
      super(message)
    end
  end
end
