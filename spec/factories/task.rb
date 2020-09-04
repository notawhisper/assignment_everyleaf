# 「FactoryBotを使用します」という記述
FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    title { 'あいうえお' }
    description { 'Factoryで作ったデフォルトのコンテント１' }
    deadline { '2018-09-02 00:00:00' }
    status { '未着手' }
    priority { '高' }
  end
  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    title { 'かきくけこ' }
    description { 'Factoryで作ったデフォルトのコンテント２' }
    deadline { '2019-09-01 00:00:00' }
    status { '完了' }
    priority { '低' }
  end

  factory :third_task, class: Task do
    title { 'さしすせそ' }
    description { 'Factoryで作ったデフォルトのコンテント２' }
    deadline { '2019-09-01 00:00:00' }
    status { '完了' }
    priority { '中' }
  end
end
