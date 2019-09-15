# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::RolesController, type: :request do
  let!(:admin) { create(:user, :admin) }
  let!(:user) { create(:user) }
  let(:logged_user) {}
  let(:allow_update) {}
  let(:role) {}

  before { sign_in logged_user }

  describe 'POST /users/:user_id/roles' do
    subject do
      post user_roles_path(user), params: { role_name: role }
      response
    end

    context 'when user logged in' do
      let(:logged_user) { user }
      let(:role) { :admin }

      it { is_expected.to have_http_status(302) }
      it { is_expected.to redirect_to(root_path) }

      context 'redirected' do
        before do
          subject
          follow_redirect!
        end
        it 'shows alert: not authorized' do
          expect(response.body).to include(I18n.t('policy.not_authorized'))
        end
      end
    end

    context 'when admin logged in' do
      let(:logged_user) { admin }
      let(:role) { %i[admin user].sample }
      let(:allow_update) { true }

      before do
        allow_any_instance_of(User).to receive(:update).and_return(allow_update)
      end

      it { is_expected.to have_http_status(302) }
      it { is_expected.to redirect_to(user_path(user)) }

      context 'redirected' do
        before do
          subject
          follow_redirect!
        end

        context 'when role is not permitted' do
          let(:role) { :illegal_role }

          it 'shows alert: illegal role' do
            expect(response.body).to include(I18n.t('users.roles.illegal', role: role))
          end
        end

        context 'when user is banned' do
          let(:user) { create(:user, :banned) }

          it 'shows alert: can not grant role: user is banned' do
            expect(response.body).to include(I18n.t('users.roles.grant.is_banned'))
          end
        end

        context 'when admin role successfully granted' do
          let(:allow_update) { true }

          it 'shows notice: role updated' do
            expect(response.body).to include(I18n.t('users.roles.grant.success', role: role))
          end
        end

        context 'when admin role grant failed' do
          let(:allow_update) { false }

          it 'shows alert: role has not been granted' do
            expect(response.body).to include(I18n.t('users.roles.grant.failure', role: role))
          end
        end
      end
    end
  end

  describe 'DELETE /users/:user_id/roles' do
    subject do
      delete user_roles_path(user), params: { role_name: role }
      response
    end

    before do
      allow_any_instance_of(User).to receive(:update).and_return(allow_update)
    end

    context 'when user logged in' do
      let(:logged_user) { user }

      it { is_expected.to have_http_status(302) }
      it { is_expected.to redirect_to(root_path) }

      context 'redirected' do
        before do
          subject
          follow_redirect!
        end
        it 'shows alert: not authorized' do
          expect(response.body).to include(I18n.t('policy.not_authorized'))
        end
      end
    end

    context 'when admin logged in' do
      let(:logged_user) { admin }
      let(:role) { :admin }

      it { is_expected.to have_http_status(302) }
      it { is_expected.to redirect_to(user_path(user)) }

      context 'redirected' do
        before do
          subject
          follow_redirect!
        end

        context 'when role is not permitted' do
          let(:role) { :illegal_role }

          it 'shows alert: illegal role' do
            expect(response.body).to include(I18n.t('users.roles.illegal', role: role))
          end
        end

        context 'when given role is not currently assigned to user' do
          it 'shows alert: user does not have given role' do
            expect(response.body).to include(I18n.t('users.roles.not_assigned', role: role))
          end
        end

        context 'when last admin' do
          let(:user) { admin }

          it 'shows alert: can not remove last administrator' do
            expect(response.body).to include(I18n.t('users.roles.revoke.cant_remove_last_admin'))
          end
        end

        context 'when a role revoke failed' do
          let(:role) { :user }
          let(:allow_update) { false }

          it 'shows alert: role has not been revoked' do
            expect(response.body).to include(I18n.t('users.roles.revoke.failure', role: role))
          end
        end

        context 'when not last admin' do
          let!(:another_admin) { create(:user, :admin) }

          context 'when the admin role successfully revoked' do
            let(:user) { another_admin }
            let(:allow_update) { true }

            it 'shows notice: role updated' do
              expect(response.body).to include(I18n.t('users.roles.revoke.success', role: role))
            end
          end
        end
      end
    end
  end
end
