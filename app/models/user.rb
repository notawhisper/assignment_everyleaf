class User < ApplicationRecord
  before_update :one_admin_user_should_exist
  before_destroy :the_last_admin_user_cannot_be_deleted

  has_many :tasks, dependent: :destroy
  has_secure_password

  private
  def the_last_admin_user_cannot_be_deleted
    if User.where(admin: true).count == 1 && self.admin == true
      errors.add :base, '管理者数が0になるため、このユーザーは削除できません。'
      throw(:abort)
    end
  end

  def one_admin_user_should_exist
    if User.where(admin: true).count == 1 && self.admin_change == [true, false]
      errors.add :base, '管理者数が0になるため、このユーザーの管理者権限は変更できません。'
      throw(:abort)
    end
  end
end
