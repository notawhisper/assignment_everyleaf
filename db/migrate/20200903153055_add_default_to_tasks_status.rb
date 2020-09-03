class AddDefaultToTasksStatus < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :status, :string, default: '未着手'
  end

  def down
    change_column :tasks, :status, :string
  end
end
