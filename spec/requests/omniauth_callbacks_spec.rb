# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :request do
  let(:provider) { 'facebook' }
  let(:uid) { '1234567890' }
  before do
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      provider: provider,
      uid: uid,
      info: { email: 'example@example.com', name: 'Johnnie Walker' },
      extra: { raw_info: { email: 'example@example.com' } }
    )
  end

  after(:each) do
    OmniAuth.config.mock_auth[:facebook] = nil
  end

  context 'when facebook returns authentication error' do
    before do
      OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
      # redirect to the users/auth/failure endpoint
      OmniAuth.config.on_failure = proc { |env|
        OmniAuth::FailureEndpoint.new(env).redirect_to_failure
      }
      post user_facebook_omniauth_authorize_path
    end

    it 'redirects to facebook omniauth callback path' do
      expect(response.status).to eq 302
      expect(response).to redirect_to user_facebook_omniauth_callback_path
    end

    context 'following redirect' do
      before { follow_redirect! }

      it 'redirects to users auth failure path' do
        response_params = { message: 'invalid_credentials', strategy: 'facebook' }
        expect(response.status).to eq 302
        expect(response).to redirect_to users_auth_failure_path(response_params)
      end
    end
  end

  context 'when facebook returns successful authentication' do
    before { post user_facebook_omniauth_authorize_path }

    context 'for a new user' do
      it 'redirects to facebook omniauth callback path' do
        expect(response.status).to eq 302
        expect(response).to redirect_to user_facebook_omniauth_callback_path
      end

      it 'creates a new user' do
        expect { follow_redirect! }.to change(User, :count).by(1)
      end

      context 'following redirect' do
        before { follow_redirect! }

        it 'sets the attributes on the user' do
          user = User.last
          info = OmniAuth.config.mock_auth[:facebook].info

          expect(user.email).to eq info.email
          expect(user.name).to eq info.name
        end

        it 'displays the expected flash message' do
          expect(flash[:notice]).to match('Successfully authenticated from Facebook account.')
        end

        it 'redirects to root path' do
          expect(response).to redirect_to root_path
        end
      end

      it 'does not put facebook data to session' do
        expect(session['devise.facebook_data']).to be_nil
      end
    end

    context 'for existing user' do
      subject! { create(:user, provider: provider, uid: uid) }

      it 'redirects to facebook omniauth callback path' do
        expect(response).to redirect_to user_facebook_omniauth_callback_path
      end

      it 'does not create a new user' do
        expect { follow_redirect! }.not_to change(User, :count)
      end

      context 'following redirect' do
        before { follow_redirect! }

        it 'displays the expected flash message' do
          expect(flash[:notice]).to match('Successfully authenticated from Facebook account.')
        end

        it 'redirects to root path' do
          expect(response).to redirect_to root_path
        end
      end
    end
  end

  context 'when user is not persisted' do
    before do
      allow_any_instance_of(User).to receive(:persisted?).and_return(false)
      post user_facebook_omniauth_authorize_path
    end

    it 'redirects to facebook omniauth callback path' do
      expect(response.status).to eq 302
      expect(response).to redirect_to user_facebook_omniauth_callback_path
    end

    context 'following redirect' do
      before { follow_redirect! }

      it 'puts facebook data to session' do
        expect(session['devise.facebook_data']).to eq(OmniAuth.config.mock_auth[:facebook])
      end

      it 'redirects to new user registration url' do
        expect(response.status).to eq 302
        expect(response).to redirect_to new_user_registration_url
      end
    end
  end

  context 'failures callback action' do
    before { get users_auth_failure_path }
    it 'redirects to root path' do
      expect(response).to redirect_to root_path
    end
  end
end
