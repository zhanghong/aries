class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer  :user_id,   default: 0, comment: '关联用户'
      t.string  :type,   default: "", limit: 20, comment: '消息类型'
      t.text  :content, comment: '消息内容'
      t.boolean  :is_read,   default: false, comment: '是否已读'
      t.integer  :sender_id,   default: 0, comment: '发送用户ID'
      t.integer  :updater_id,   default: 0, comment: '更新用户ID'
      t.timestamps null: false
    end

    add_index :messages,  [:user_id,  :is_read],  name: "idx_by_user_id_and_is_read"
  end
end
