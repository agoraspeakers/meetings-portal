# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let(:users) { create_list(:user, 10) }
  let(:admin) { users.find { |u| u.role.eql? 'admin' } }
  let(:user) { users.find { |u| u.role.eql? nil } }
  let(:logged_user) {}
  before { sign_in logged_user }

  describe 'GET /users' do
    before { get users_path }

    context 'when user logged in' do
      let(:logged_user) { user }

      it { expect(response).to have_http_status(302) }
      it { expect(response).to redirect_to(root_path) }
      it 'shows alert: not authorized' do
        follow_redirect!
        expect(response.body).to include(I18n.t('policy.not_authorized'))
      end
    end

    context 'when admin logged in' do
      let(:logged_user) { admin }

      it { expect(response).to have_http_status(200) }
      it { expect(response).to render_template(:index) }
    end
  end

  describe 'GET /users/show' do
    before { get user_path(user) }

    context 'when user logged in' do
      context 'when user shows himself profile' do
        let(:logged_user) { user }

        it { expect(response).to have_http_status(200) }
        it { expect(response).to render_template(:show) }
      end

      context 'when user shows other user profile' do
        let(:logged_user) { users.find { |u| u.role.eql?(nil) && u.id != user.id } }

        it { expect(response).to have_http_status(302) }
        it { expect(response).to redirect_to(root_path) }
        it 'shows alert: not authorized' do
          follow_redirect!
          expect(response.body).to include(I18n.t('policy.not_authorized'))
        end
      end
    end

    context 'when admin logged in' do
      let(:logged_user) { admin }

      it { expect(response).to have_http_status(200) }
      it { expect(response).to render_template(:show) }
    end
  end

  describe 'PATCH /users/1' do
    let(:allow_update) {}

    before do
      allow_any_instance_of(User).to receive(:update).and_return(allow_update)
      patch set_admin_user_path(user), params: { role: { admin: true } }
    end

    context 'when user logged in' do
      let(:logged_user) { user }

      it { expect(response).to have_http_status(302) }
      it { expect(response).to redirect_to(root_path) }
      it 'shows alert: not authorized' do
        follow_redirect!
        expect(response.body).to include(I18n.t('policy.not_authorized'))
      end
    end

    context 'when admin logged in' do
      let(:logged_user) { admin }

      context 'when admin role successfully updated' do
        let(:allow_update) { true }

        it { expect(response).to have_http_status(302) }
        it { expect(response).to redirect_to(user_path(user)) }
        it 'shows notice: role updated' do
          follow_redirect!
          expect(response.body).to include(I18n.t('users.set_admin.role_updated'))
        end
      end

      context 'when admin role update failed' do
        let(:allow_update) { false }

        it { expect(response).to have_http_status(200) }
        it { expect(response).to render_template(:show) }
        it { expect(response.body).to include(I18n.t('users.set_admin.role_not_updated')) }
      end
    end
  end
end
