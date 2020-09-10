require 'rails_helper'

RSpec.describe Label, type: :model do
  describe 'バリデーション機能' do
    context 'nameが空の場合' do
      it 'バリデーションに弾かれる' do
        invalid_label = Label.new(name: "")
        expect(invalid_label).not_to be_valid
      end
    end
  end
end
