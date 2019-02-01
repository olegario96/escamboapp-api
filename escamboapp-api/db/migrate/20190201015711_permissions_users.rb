class PermissionsUsers < ActiveRecord::Migration[5.2]
  def change
    create_join_table :permissions, :users do |t|
      t.index [:permission_id, :user_id]
      t.index [:user_id, :permission_id]
    end
    add_foreign_key :permissions_users, :permissions
    add_foreign_key :permissions_users, :users
  end
end
