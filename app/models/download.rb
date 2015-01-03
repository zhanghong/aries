# create_table "downloads", force: :cascade do |t|
#   t.integer  "user_id",      limit: 4,     default: 0,               comment: "所属用户ID"
#   t.string   "status",       limit: 30,    default: "",              comment: "下载文件状态"
#   t.string   "target_type",  limit: 30,    default: "",              comment: "下载任务类型"
#   t.text     "conditions",   limit: 65535,                           comment: "下载条件"
#   t.integer  "record_count", limit: 4,     default: 0,               comment: "下载数据条数"
#   t.string   "file_path",    limit: 100,   default: "",              comment: "下载文件路径"
#   t.integer  "file_size",    limit: 4,     default: 0,               comment: "文件大小"
#   t.integer  "down_count",   limit: 4,     default: 0,               comment: "下载次数"
#   t.datetime "created_at",                              null: false
#   t.datetime "updated_at",                              null: false
# end
# add_index "downloads", ["target_type", "user_id"], name: "idx_by_target_type_and_user_id", using: :btree
# add_index "downloads", ["user_id"], name: "idx_by_user_id", using: :btree
class Download < ActiveRecord::Base
  belongs_to  :user
  has_many    :download_logs
end