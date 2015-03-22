# create_table "task_logs", force: :cascade do |t|
#   t.integer  "task_id",      limit: 4,                               comment: "所属买手任务id"
#   t.string   "status",       limit: 30,    default: "",              comment: "状态"
#   t.string   "sub_status",   limit: 30,    default: "",              comment: "子状态"
#   t.text     "contents",     limit: 65535,                           comment: "更新内容"
#   t.string   "memo",         limit: 255,   default: "",              comment: "备注"
#   t.integer  "used_seconds", limit: 4,     default: 0,               comment: "使用时间（秒）"
#   t.integer  "updater_id",   limit: 4,     default: 0,               comment: "更新用户ID"
#   t.datetime "created_at",                              null: false
#   t.datetime "updated_at",                              null: false
# end
# add_index "task_logs", ["task_id"], name: "idx_by_task_id", using: :btree
class TaskLog < ActiveRecord::Base
  belongs_to  :task
  belongs_to  :updater, class_name: "User"
end