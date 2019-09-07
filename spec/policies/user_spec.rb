# frozen_string_literal: true

require 'rails_helper'

describe UserPolicy do
  subject { described_class }
  let!(:admin)  { create(:user, role: :admin) }
  let!(:user) { create(:user, role: nil) }

  permissions :index? do
    it 'denies access if user is not admin' do
      expect(subject).not_to permit(user, User.all)
    end

    it 'grants access if user is admin' do
      expect(subject).to permit(admin, User.all)
    end
  end

  permissions :show? do
    it 'denies access if user is not eql record' do
      expect(subject).not_to permit(user, admin)
    end

    it 'grants access if user eql record' do
      expect(subject).to permit(user, user)
    end

    it 'grants access if user is admin' do
      expect(subject).to permit(admin, user)
    end
  end

  permissions :set_admin? do
    it 'denies access if user is not admin' do
      expect(subject).not_to permit(user, admin)
    end

    it 'grants access if user is admin' do
      expect(subject).to permit(admin, user)
    end
  end
end
