# create_table "messages", force: :cascade do |t|
#   t.integer  "user_id",    limit: 4,     default: 0,                  comment: "关联用户"
#   t.string   "type",       limit: 20,    default: "",                 comment: "消息类型"
#   t.text     "content",    limit: 65535,                              comment: "消息内容"
#   t.boolean  "is_read",    limit: 1,     default: false,              comment: "是否已读"
#   t.integer  "sender_id",  limit: 4,     default: 0,                  comment: "发送用户ID"
#   t.integer  "updater_id", limit: 4,     default: 0,                  comment: "更新用户ID"
#   t.datetime "created_at",                               null: false
#   t.datetime "updated_at",                               null: false
# end
# add_index "messages", ["user_id", "is_read"], name: "idx_by_user_id_and_is_read", using: :btree
class Message < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :sender,  class_name: "User"
  belongs_to  :updater, class_name: "User"
end