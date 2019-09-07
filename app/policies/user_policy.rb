# frozen_string_literal: true

# User Policy
class UserPolicy < ApplicationPolicy
  def index?
    user&.admin?
  end

  def show?
    record.id.eql?(user&.id) || user&.admin?
  end

  def set_admin?
    user&.admin?
  end
end
