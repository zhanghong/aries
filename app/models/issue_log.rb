# create_table "issue_logs", force: :cascade do |t|
#   t.integer  "issue_id",   limit: 4,     default: 0,                      comment: "所属发布任务ID"
#   t.string   "status",     limit: 20,    default: "pinding",              comment: "状态"
#   t.text     "content",    limit: 65535,                                  comment: "更新内容"
#   t.string   "memo",       limit: 255,   default: "",                     comment: "备注"
#   t.integer  "updater_id", limit: 4,     default: 0,                      comment: "更新用户ID"
#   t.datetime "created_at",                                   null: false
#   t.datetime "updated_at",                                   null: false
# end
# add_index "issue_logs", ["issue_id"], name: "idx_by_issue_id", using: :btree
class IssueLog < ActiveRecord::Base
  belongs_to  :issue
  belongs_to  :updater, class_name: "User"
end
