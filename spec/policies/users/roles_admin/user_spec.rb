# frozen_string_literal: true

require 'rails_helper'

describe Users::RolesAdmin::UserPolicy do
  subject { described_class }
  let!(:admin)  { create(:user, role: :admin) }
  let!(:user) { create(:user, role: :user) }

  permissions :create?, :destroy? do
    it 'denies access if user is not admin' do
      expect(subject).not_to permit(user, admin)
    end

    it 'grants access if user is admin' do
      expect(subject).to permit(admin, user)
    end
  end
end
