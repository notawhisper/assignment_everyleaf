require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:admin_user) { FactoryBot.create(:admin_user) }
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
    context '一般ユーザーでログインした場合' do
      before do
        visit login_path
        fill_in 'session[email]', with: 'user1@test.com'
        fill_in 'session[password]', with: 'testtest'
        click_on 'ログインする'
      end

      it 'ログインが正常に行われる' do
        expect(page).to have_content 'user1@test.com'
      end

      it '他人の詳細画面に飛ぶとタスク一覧画面に遷移する' do
        visit user_path(admin_user.id)
        expect(page).to have_content '達成期限でソート'
      end

      it 'ログアウトができる' do
        click_on 'ログアウト'
        expect(page).to have_content 'ログイン'
      end
    end
  end

  describe '管理機能' do
    context '管理ユーザーとしてログインしている場合' do
      before do
        visit login_path
        fill_in 'session[email]', with: 'admin1@test.com'
        fill_in 'session[password]', with: 'testtest'
        click_on 'ログインする'
      end

      it 'ログインが正常に行われる' do
        expect(page).to have_content 'admin1@test.com'
      end

      it '管理画面にアクセスできる' do
        visit admin_users_path
        expect(current_path).to eq admin_users_path
      end

      it 'ユーザーの新規登録ができる' do
        visit new_admin_user_path
        fill_in User.human_attribute_name(:name), with: '新規作成2'
        fill_in User.human_attribute_name(:email), with: 'newuser2@test.com'
        fill_in User.human_attribute_name(:password), with: 'testtest'
        fill_in User.human_attribute_name(:password_confirmation), with: 'testtest'
        click_on '登録する'

        expect(page).to have_content 'newuser2@test.com'
      end

      it 'ユーザー詳細画面にアクセスできる' do
        visit admin_user_path(user.id)
        expect(page).to have_content user.name
      end

      it '編集画面からユーザーを編集できる' do
        visit edit_admin_user_path(user.id)
        fill_in User.human_attribute_name(:name), with: '編集できる'
        click_on '登録する'
        expect(page).to have_content '編集できる'
      end

      it 'ユーザーの削除をできる' do
        visit admin_users_path
        page.accept_confirm { first('tbody tr').click_link '削除' }
        expect(page).to_not have_content 'user1@test.com'
      end
    end
  end
end
