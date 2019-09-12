# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::AdminController, type: :request do
  let!(:admin) { create(:user, :admin) }
  let!(:user) { create(:user) }
  let(:logged_user) {}

  before { sign_in logged_user }

  describe 'POST /users/1/admin' do
    let(:allow_update) {}

    subject do
      post user_admin_path(user)
      response
    end

    before do
      allow_any_instance_of(User).to receive(:update).and_return(allow_update)
    end

    context 'when user logged in' do
      let(:logged_user) { user }

      it { is_expected.to have_http_status(302) }
      it { is_expected.to redirect_to(root_path) }
      it 'shows alert: not authorized' do
        subject
        follow_redirect!
        expect(response.body).to include(I18n.t('policy.not_authorized'))
      end
    end

    context 'when admin logged in' do
      let(:logged_user) { admin }

      context 'when admin role successfully granted' do
        let(:allow_update) { true }

        it { is_expected.to have_http_status(302) }
        it { is_expected.to redirect_to(user_path(user)) }
        it 'shows notice: role updated' do
          subject
          follow_redirect!
          expect(response.body).to include(I18n.t('users.admin.create.success'))
        end
      end

      context 'when admin role grant failed' do
        let(:allow_update) { false }

        it { is_expected.to have_http_status(302) }
        it { is_expected.to redirect_to(user_path(user)) }
        it do
          subject
          follow_redirect!
          expect(response.body).to include(I18n.t('users.admin.create.failure'))
        end
      end
    end
  end

  describe 'DELETE /users/1/admin' do
    let(:allow_update) {}

    subject do
      delete user_admin_path(user)
      response
    end

    before do
      allow_any_instance_of(User).to receive(:update).and_return(allow_update)
    end

    context 'when user logged in' do
      let(:logged_user) { user }

      it { is_expected.to have_http_status(302) }
      it { is_expected.to redirect_to(root_path) }
      it 'shows alert: not authorized' do
        subject
        follow_redirect!
        expect(response.body).to include(I18n.t('policy.not_authorized'))
      end
    end

    context 'when admin logged in' do
      let(:logged_user) { admin }

      context 'when not last admin' do
        let!(:another_admin) { create(:user, :admin) }

        context 'when the admin role successfully revoked' do
          let(:allow_update) { true }

          it { is_expected.to have_http_status(302) }
          it { is_expected.to redirect_to(user_path(user)) }
          it 'shows notice: role updated' do
            subject
            follow_redirect!
            expect(response.body).to include(I18n.t('users.admin.destroy.success'))
          end
        end

        context 'when the admin role revoke failed' do
          let(:allow_update) { false }

          it { is_expected.to have_http_status(302) }
          it { is_expected.to redirect_to(user_path(user)) }
          it do
            subject
            follow_redirect!
            expect(response.body).to include(I18n.t('users.admin.destroy.failure'))
          end
        end
      end

      context 'when last admin' do
        it { is_expected.to have_http_status(302) }
        it { is_expected.to redirect_to(user_path(user)) }
        it 'shows alert: not authorized' do
          subject
          follow_redirect!
          expect(response.body).to include(I18n.t('users.admin.destroy.cant_remove_last_admin'))
        end

      end
    end
  end
end
