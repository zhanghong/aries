# create_table "issue_schedulers", force: :cascade do |t|
#   t.integer  "issue_id",         limit: 4,  default: 0,                      comment: "关联商家发布任务"
#   t.string   "status",           limit: 20, default: "pinding",              comment: "状态"
#   t.integer  "interval_minutes", limit: 4,  default: 0,                      comment: "间隔分钟"
#   t.integer  "pc_number",        limit: 4,  default: 0,                      comment: "PC端每次发布订单数量"
#   t.integer  "mobile_number",    limit: 4,  default: 0,                      comment: "移动端每次发布订单数量"
#   t.integer  "updater_id",       limit: 4,  default: 0,                      comment: "更新用户ID"
#   t.datetime "created_at",                                      null: false
#   t.datetime "updated_at",                                      null: false
# end
# add_index "issue_schedulers", ["issue_id"], name: "idx_by_issue_id", using: :btree
class IssueScheduler < ActiveRecord::Base
  belongs_to  :issue
  belongs_to  :updater, class_name: "User"
end
