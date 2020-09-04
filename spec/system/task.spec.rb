require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task, title: 'タスク1', description: 'あいうえお')
    FactoryBot.create(:second_task, title: 'タスク2', description: 'かきくけこ')
  end

  describe '新規作成機能' do
    before do
      visit new_task_path
    end
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
      fill_in Task.human_attribute_name(:title), with: 'しんきさくせい'
      fill_in Task.human_attribute_name(:description), with: 'aaa'
      fill_in 'Deadline', with: DateTime.new(2000, 12, 31, 23, 55, 0)
      select '着手中', from: 'Status'
      click_on '登録する'
      expect(page).to have_content 'しんきさくせい'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title: 'task', description: 'test')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content('タスク1')
      end
    end
    context '終了期限でソートした場合' do
      it '終了期限の降順に並び替えられたタスク一覧が表示される' do
        visit tasks_path
        click_on '終了期限でソート'
        sleep 0.8 #テストの挙動が安定しないため挿入
        task_list = all('.task_row_deadline')
        expect(task_list[0]).to have_content('2019')
        expect(task_list[1]).to have_content('2018')
      end
    end
    context '優先度でソートした場合' do
      it '優先度の高い順に並び替えられたタスク一覧が表示される' do
        FactoryBot.create(:third_task)
        visit tasks_path
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
      FactoryBot.create(:task, title: "task", status: '完了')
      FactoryBot.create(:second_task, title: "sample", description: '表示されない', status: '未着手')
      FactoryBot.create(:third_task, title: "sample", description: '表示される', status: '完了')
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
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
        visit tasks_path
        select '完了', from: 'task_search_for_status'
        click_on 'search'
        expect(page).to have_content 'task'
        expect(page).not_to have_content '表示されない'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        fill_in 'task_search_for_title', with: 'sam'
        select '完了', from: 'task_search_for_status'
        click_on 'search'
        expect(page).to have_content '表示される'
        expect(page).not_to have_content '表示されない'
      end
    end
  end
end
