# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Location, type: :model do
  describe '#initialize_from_string' do
    context 'when user provided a valid location name' do
      subject { Location.initialize_from_string('Gorzów Wlkp.') }
      it 'then the location is valid' do
        expect(subject).to be_valid
        expect(subject.name).to eq('Gorzów Wielkopolski, Lubusz Voivodeship, Poland')
        expect(subject.latitude).to eq(52.7309926)
        expect(subject.longitude).to eq(15.2400451)
      end
    end

    context 'when user provided an invalid location name' do
      subject { Location.initialize_from_string('some random location name') }
      it 'then the location is nil' do
        expect(subject).to eq(nil)
      end
    end
  end
end
