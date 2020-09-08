require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, user: user) }
  let!(:task2) { FactoryBot.create(:second_task, user: user) }
  let!(:task3) { FactoryBot.create(:third_task, user: user) }

  before do
    visit login_path
    fill_in 'session[email]', with: 'user1@test.com'
    fill_in 'session[password]', with: 'testtest'
    click_on 'ログインする'
    visit tasks_path
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in Task.human_attribute_name(:title), with: 'しんきさくせい'
        fill_in Task.human_attribute_name(:description), with: 'latest deadline'
        fill_in Task.human_attribute_name(:deadline), with: DateTime.new(2020, 10, 31, 23, 55, 0)
        select '未着手', from: 'ステータス'
        click_on '登録する'
        expect(page).to have_content 'しんきさくせい'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'タスク1'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row_title')
        sleep 0.8
        expect(task_list[0]).to have_content('タスク3')
        expect(task_list[1]).to have_content('タスク2')
        expect(task_list[2]).to have_content('タスク1')
      end
    end
    context '終了期限でソートした場合' do
      it '終了期限の降順に並び替えられたタスク一覧が表示される' do
        click_on '達成期限でソート'
        sleep 0.8 #テストの挙動が安定しないため挿入
        task_list = all('.task_row_deadline')
        expect(task_list[0]).to have_content('2020')
        expect(task_list[1]).to have_content('2019')
        expect(task_list[2]).to have_content('2018')
      end
    end
    context '優先度でソートした場合' do
      it '優先度の高い順に並び替えられたタスク一覧が表示される' do
        click_on '優先度でソート'
        sleep 0.8 #テストの挙動が安定しないため挿入
        task_list = all('.task_row_priority')
        expect(task_list[0]).to have_content('高')
        expect(task_list[1]).to have_content('中')
        expect(task_list[2]).to have_content('低')
      end
    end
  end

  describe '検索機能' do
    before do
      FactoryBot.create(:task, title: "task", status: '完了', user: user)
      FactoryBot.create(:second_task, title: "sample", description: '表示されない', status: '未着手', user: user)
      FactoryBot.create(:third_task, title: "sample", description: '表示される', status: '完了', user: user)
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        # タスクの検索欄に検索ワードを入力する (例: task)
        fill_in 'task_search_for_title', with: 'ta'
        # 検索ボタンを押す
        click_on 'search'
        sleep 0.8 #テストの挙動が安定しないため挿入
        expect(page).to have_content 'task'
        expect(page).not_to have_content 'sample'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        select '完了', from: 'task_search_for_status'
        click_on 'search'
        expect(page).to have_content 'task'
        expect(page).not_to have_content '表示されない'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる" do
        fill_in 'task_search_for_title', with: 'sam'
        select '完了', from: 'task_search_for_status'
        click_on 'search'
        expect(page).to have_content '表示される'
        expect(page).not_to have_content '表示されない'
      end
    end
  end
end
