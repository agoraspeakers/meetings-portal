# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#new_with_session' do
    subject { User.new_with_session(params, session) }
    let(:params) { {} }
    let(:session) do
      {
          'devise.facebook_data':
              OmniAuth::AuthHash.new(
                  provider: 'facebook',
                uid: '1234567890',
                info: { email: 'example@example.com', id: '1234567890', name: 'Johnnie Walker' },
                extra: { raw_info: { email: 'example@example.com' } }
              )
      }
    end

    context 'when user does not have assigned email' do
      context 'when session contains email' do
        it 'assigns email from session to user' do
          expect(subject.email).to eq('example@example.com')
        end
      end

      context 'when session does not contain email' do
        let(:session) { {} }
        it 'does not assign email to user' do
          expect(subject.email).to eq('')
        end
      end
    end

    context 'when user has assigned email' do
      let(:params) { { email: 'first_email@example.com' } }
      context 'when session contains email' do
        it 'does not assign email to user' do
          expect(subject.email).to eq('first_email@example.com')
        end
      end

      context 'when session does not contain email' do
        let(:session) { {} }
        it 'does not assign email to user' do
          expect(subject.email).to eq('first_email@example.com')
        end
      end
    end
  end

  describe '#from_omniauth' do
    subject { User.from_omniauth(auth) }

    context 'when user exists' do
      let(:user) { create(:user) }
      let(:auth) { OmniAuth::AuthHash.new(provider: user.provider, uid: user.uid) }

      it 'finds user by provider and uid fields' do
        expect(subject).to eq(user)
      end
    end

    context 'when user does not exist' do
      let(:auth) do
        OmniAuth::AuthHash.new(
            provider: 'facebook',
          uid: Faker::Internet.unique.uuid,
          info: { email: Faker::Internet.unique.email, name: Faker::Name.name, image: nil }
          )
      end

      it 'creates new user with given provider and uid fields' do
        expect { subject }.to change(User, :count).by(1)
      end

      it 'assigns email, name and image to new user' do
        expect(subject.email).to eq(auth.info.email)
        expect(subject.name).to eq(auth.info.name)
        expect(subject.image).to eq(auth.info.image)
      end
    end
  end

  describe '#create' do
    context 'can save user' do
      it 'is valid with a name, email, password, password_confirmation and location' do
        user = build(:user)
        expect(user).to be_valid
      end

      it 'is valid without location' do
        user = build(:user, location: nil)
        expect(user).to be_valid
      end
    end
  end

  describe '#create' do
    context 'can save user' do
      it 'is valid with a name, email, password, password_confirmation and location' do
        user = build(:user)
        expect(user).to be_valid
      end

      it 'is valid with a name, email, password, password_confirmation and without location' do
        user = build(:user, location: nil)
        expect(user).to be_valid
      end
    end
  end

  describe '#edit' do
    context 'can edit user' do
      it 'location' do
        updated_location = 'Gorzów Wielkopolski, Poland'
        user = build(:user, location: updated_location)
        expect(user).to be_valid
        expect(user.location).to eq(updated_location)
      end
    end
  end
end
