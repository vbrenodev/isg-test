# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment do
  let(:comment) { build(:comment) }

  describe 'associations' do
    it { is_expected.to belong_to(:post) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
    it { is_expected.to validate_presence_of(:text) }
    it { is_expected.to validate_length_of(:text).is_at_most(1000) }
  end

  describe 'scopes' do
    it 'has a default scope that filters out deleted comments' do
      comment.destroy
      expect(described_class.all).not_to include(comment)
    end
  end

  describe 'methods' do
    describe '#destroy' do
      it 'updates the deleted_at attribute' do
        comment.destroy
        expect(comment.deleted_at).not_to be_nil
      end
    end

    describe '#deleted?' do
      it 'returns true if the comment is deleted' do
        comment.destroy
        expect(comment.deleted?).to be true
      end

      it 'returns false if the comment is not deleted' do
        expect(comment.deleted?).to be false
      end
    end
  end
end
