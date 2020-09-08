require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  describe '一般ユーザー関連' do
    context 'ユーザーを登録した場合' do
      before do
        visit new_user_path
      end
      it '作成したユーザーの詳細ページにいく' do
        fill_in User.human_attribute_name(:name), with: '新規作成'
        fill_in User.human_attribute_name(:email), with: 'newuser@test.com'
        fill_in User.human_attribute_name(:password), with: 'testtest'
        fill_in User.human_attribute_name(:password_confirmation), with: 'testtest'
        click_on '登録する'
        expect(page).to have_content 'newuser@test.com'
      end
    end

    context 'ログインせずにタスク一覧にアクセスしようとした場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'ログイン'
      end
    end
  end

  describe 'セッション機能' do
    before do
      FactoryBot.create(:user)
      FactoryBot.create(:admin_user)
    end
    context 'ログインした場合' do
      before do
        visit login_path
        fill_in User.human_attribute_name(:email), with: 'user1@test.com'
        fill_in User.human_attribute_name(:password), with: 'testtest'
      end
      it 'ログインが正常に行われる' do
        expect(page).to have_content 'user1@test.com'
      end
    end
  end
end
