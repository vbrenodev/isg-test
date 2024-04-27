# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  let(:user) { build(:user) }

  describe 'associations' do
    it { is_expected.to have_many(:posts).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_length_of(:password).is_at_least(6).on(%i[create update]) }
    it { is_expected.to validate_length_of(:password_confirmation).is_at_least(6).on(%i[create update]) }
    it { is_expected.to validate_confirmation_of(:password).on(%i[create update]) }
  end

  describe 'scopes' do
    it 'has a default scope that excludes deleted users' do
      user.destroy
      expect(described_class.all).not_to include(user)
    end
  end

  describe 'methods' do
    describe '#destroy' do
      it 'sets deleted_at attribute when destroy is called' do
        user.destroy
        expect(user.deleted_at).to be_present
      end
    end

    describe '#deleted?' do
      it 'returns true if user is deleted' do
        user.destroy
        expect(user.deleted?).to be true
      end

      it 'returns false if user is not deleted' do
        expect(user.deleted?).to be false
      end
    end
  end
end
