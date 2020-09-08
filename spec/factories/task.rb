# 「FactoryBotを使用します」という記述
FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    title { 'タスク1' }
    description { 'タスク1' }
    deadline { '2018-09-01 00:00:00' }
    status { '未着手' }
    priority { '高' }
    user
  end
  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    title { 'タスク2' }
    description { 'タスク2' }
    deadline { '2019-09-01 00:00:00' }
    status { '完了' }
    priority { '低' }
    user
  end

  factory :third_task, class: Task do
    title { 'タスク3' }
    description { 'タスク3' }
    deadline { '2020-09-01 00:00:00' }
    status { '完了' }
    priority { '中' }
    user
  end
end
