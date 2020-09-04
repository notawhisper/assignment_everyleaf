require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', description: '失敗テスト', deadline: DateTime.now)
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        # ここに内容を記載する
        task = Task.new(title: 'task', description: '', deadline: DateTime.now)
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        # ここに内容を記載する
        task = Task.new(title: 'task', description: '通ります', deadline: DateTime.now)
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    # 必要に応じて、テストデータの内容を変更して構わない
    before do
        @task1 = FactoryBot.create(:task)
        @task2 = FactoryBot.create(:second_task)
        @task3 = FactoryBot.create(:third_task)
      end
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
        expect(Task.search_for_title('あいうえお')).to include(@task1)
        expect(Task.search_for_title('あいうえお')).not_to include(@task2)
        expect(Task.search_for_title('あいうえお').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_for_status('未着手')).to include(@task1)
        expect(Task.search_for_status('未着手')).not_to include(@task2)
        expect(Task.search_for_status('未着手').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.search_for_title('かきくけこ').search_for_status('完了')).to include(@task2)
        expect(Task.search_for_title('かきくけこ').search_for_status('完了')).not_to include(@task3)
        expect(Task.search_for_title('かきくけこ').search_for_status('完了').count).to eq 1
      end
    end
  end
end
