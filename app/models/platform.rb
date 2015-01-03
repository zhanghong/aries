# create_table "platforms", force: :cascade do |t|
#   t.string   "name",       limit: 30,  default: "",              comment: "平台名"
#   t.string   "image",      limit: 255, default: "",              comment: "图片"
#   t.integer  "updater_id", limit: 4,   default: 0,               comment: "更新用户"
#   t.datetime "deleted_at",                                       comment: "删除时间"
#   t.datetime "created_at",                          null: false
#   t.datetime "updated_at",                          null: false
# end
class Platform < ActiveRecord::Base
  has_many  :tasks
  has_many  :issues
  has_many  :account_types
  has_many  :accounts
end