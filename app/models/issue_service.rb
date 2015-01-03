# create_table "issue_services", force: :cascade do |t|
#   t.integer  "issue_id",     limit: 4,                           default: 0,                comment: "所属发布任务"
#   t.string   "service_name", limit: 30,                          default: "",               comment: "服务名"
#   t.decimal  "unit_price",               precision: 5, scale: 2, default: 0.0,              comment: "服务单价"
#   t.integer  "number",       limit: 4,                           default: 1,                comment: "购买数量"
#   t.decimal  "total_price",              precision: 5, scale: 2, default: 0.0,              comment: "总价"
#   t.string   "return_type",  limit: 255,                                                    comment: "返还类型"
#   t.string   "updater_id",   limit: 255,                         default: "0",              comment: "更新用户"
#   t.datetime "created_at",                                                     null: false
#   t.datetime "updated_at",                                                     null: false
# end
# add_index "issue_services", ["issue_id"], name: "idx_by_issue_id", using: :btree
class IssueService < ActiveRecord::Base
  belongs_to  :issue
  belongs_to  :updater, class_name: "User"
end