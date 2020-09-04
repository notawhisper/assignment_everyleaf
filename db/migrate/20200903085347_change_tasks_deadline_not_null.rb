class ChangeTasksDeadlineNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :deadline, false
  end
end
