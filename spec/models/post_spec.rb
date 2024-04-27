# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post do
  let(:post) { build(:post) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(100) }
    it { is_expected.to validate_presence_of(:text) }
    it { is_expected.to validate_length_of(:text).is_at_most(1000) }
  end

  describe 'scopes' do
    it 'has a default scope that excludes deleted posts' do
      post.destroy
      expect(described_class.all).not_to include(post)
    end
  end

  describe 'methods' do
    describe '#destroy' do
      it 'updates the deleted_at attribute' do
        post.destroy
        expect(post.deleted_at).to be_present
      end
    end

    describe '#deleted?' do
      it 'returns true if the post is deleted' do
        post.destroy
        expect(post.deleted?).to be true
      end

      it 'returns false if the post is not deleted' do
        expect(post.deleted?).to be false
      end
    end
  end
end
