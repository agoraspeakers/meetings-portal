# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let(:users) { create_list(:user, 10) }
  let(:user) { users.first }
  before(:each) { sign_in user }

  describe 'GET /users' do
    before { get users_path }

    it { expect(response).to have_http_status(200) }
    it { expect(response).to render_template(:index) }
    it { expect(response.body).to include(*users.map(&:name), *users.map(&:email)) }
  end

  describe 'GET /farms/show' do
    before { get user_path(user) }

    it { expect(response).to have_http_status(200) }
    it { expect(response).to render_template(:show) }
    it { expect(response.body).to include(user.name, user.email) }
  end

  describe 'PATCH /users/1' do
    let(:second_user) { users.second }
    let(:allow_update) {}

    before do
      allow_any_instance_of(User).to receive(:update).and_return(allow_update)
      patch set_admin_user_path(second_user), params: { role: { admin: true } }
    end

    context 'when set/unset admin role successfully updated' do
      let(:allow_update) { true }

      it { expect(response).to have_http_status(302) }
      it { expect(response).to redirect_to(user_path(second_user)) }
      it 'shows notice: Role has been successfully updated' do
        follow_redirect!
        expect(response.body).to include(I18n.t('users.set_admin.role_updated'))
      end
    end

    context 'when set/unset admin role failed' do
      let(:allow_update) { false }

      it { expect(response).to have_http_status(200) }
      it { expect(response).to render_template(:show) }
      it { expect(response.body).to include(I18n.t('users.set_admin.role_not_updated')) }
    end
  end
end
