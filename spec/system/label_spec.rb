require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:admin_user) { FactoryBot.create(:admin_user) }
  let!(:label) { FactoryBot.create(:label) }
  let!(:second_label) { FactoryBot.create(:second_label) }
  let!(:task) { FactoryBot.create(:task, user: user) }
  let!(:second_task) { FactoryBot.create(:second_task, user: user) }

  describe 'ラベルCRUD機能' do
    context '一般ユーザーとしてログインしている場合' do
      before do
        visit login_path
        fill_in 'session[email]', with: 'user1@test.com'
        fill_in 'session[password]', with: 'testtest'
        click_on 'ログインする'
      end
      it 'ラベル作成画面にアクセスできない' do
        visit new_admin_label_path
        expect(current_path).to eq tasks_path
      end
      it 'ラベル一覧画面にアクセスできない' do
        visit admin_labels_path
        expect(current_path).to eq tasks_path
      end
      it 'ラベル編集画面にアクセスできない' do
        visit edit_admin_label_path(label)
        expect(current_path).to eq tasks_path
      end

      it 'ラベル詳細画面にアクセスできない' do
        visit admin_label_path(label)
        expect(current_path).to eq tasks_path
      end
    end

    context '管理者としてログインしている場合' do
      before do
        visit login_path
        fill_in 'session[email]', with: 'admin1@test.com'
        fill_in 'session[password]', with: 'testtest'
        click_on 'ログインする'
      end
      it 'ラベル一覧画面にアクセスし、ラベル一覧を確認できる' do
        visit admin_labels_path
        expect(page).to have_content('MyString')
        expect(page).to have_content('HisOrHerString')
      end
      it 'ラベルが新規作成できる' do
        visit new_admin_label_path
        fill_in "Name", with: 'しんきさくせい'
        click_on '登録する'
        expect(page).to have_content('しんきさくせい')
      end
      it 'ラベルが編集できる' do
        visit edit_admin_label_path(second_label)
        fill_in 'Name', with: 'HisOrHerStringEditted'
        click_on '更新する'
        expect(page).to have_content('HisOrHerStringEditted')
      end
      it 'ラベルが削除できる' do
        visit admin_labels_path
        page.accept_confirm { first('tbody tr').click_link 'Destroy' }
        expect(page).to have_no_content('MyString')
      end
    end

    describe 'ラベルとタスクが紐づいていることの確認' do
      before do
        visit login_path
        fill_in 'session[email]', with: 'user1@test.com'
        fill_in 'session[password]', with: 'testtest'
        click_on 'ログインする'
      end
      context 'タスクを新規作成した場合' do
        it '複数のラベルを同時に登録できる' do
          visit new_task_path
          fill_in Task.human_attribute_name(:title), with: 'ラベルテスト'
          fill_in Task.human_attribute_name(:description), with: 'ラベルを貼ります'
          fill_in Task.human_attribute_name(:deadline), with: DateTime.new(2020, 10, 31, 23, 55, 0)
          select '未着手', from: 'ステータス'
          check 'MyString'
          check 'HisOrHerString'
          click_on '登録する'
          expect(page).to have_content('MyString')
          expect(page).to have_content('HisOrHerString')
        end
      end
      context 'タスクを編集した場合' do
        it 'ラベルの情報も編集できる' do
          visit edit_task_path(second_task)
          fill_in Task.human_attribute_name(:title), with: 'ラベル編集したよ'
          check 'MyString'
          uncheck 'HisOrHerString'
          click_on '更新する'
          visit task_path(second_task)
          expect(page).to have_content('MyString')
          expect(page).to have_no_content('HisOrHerString')
        end
      end
      context 'ラベルで検索した場合' do
        it '該当ラベルが貼られたタスクが表示される' do
          visit edit_task_path(second_task)
          fill_in Task.human_attribute_name(:title), with: 'ラベル編集したよ'
          check 'MyString'
          uncheck 'HisOrHerString'
          click_on '更新する'
          visit tasks_path
          select 'MyString', from: 'task[label_id]'
          click_on 'search'
          expect(page).to have_content('ラベル編集したよ')
          expect(page).to have_no_content('タスク1')
        end
      end
    end
  end
end
