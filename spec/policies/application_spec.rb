# frozen_string_literal: true

require 'rails_helper'

describe ApplicationPolicy do
  subject { described_class }

  permissions :index?, :show?, :create?, :new?, :update?, :edit?, :destroy? do
    it 'denies access to everything' do
      expect(subject).not_to permit(create(:user), nil)
    end
  end
end
