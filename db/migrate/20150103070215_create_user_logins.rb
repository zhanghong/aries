class CreateUserLogins < ActiveRecord::Migration
  def change
    create_table :user_logins do |t|
      t.string  :user_id,   default: 0, comment: '用户ID'
      t.string  :user_agent,   default: "", comment: '浏览器信息'
      t.string  :sign_in_ip,   default: "", limit: 16, comment: '访问IP'
      t.string  :sign_in_area,   default: "", limit: 30, comment: '登录地区'
      t.timestamps null: false
    end
    add_index :user_logins, :user_id, name: "idx_by_user_id"
  end
end
