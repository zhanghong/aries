# create_table "logistic_orders", force: :cascade do |t|
#   t.string   "serial_no",   limit: 20, default: "",              comment: "物流单号"
#   t.string   "compay_code", limit: 6,  default: "",              comment: "物流公司编号"
#   t.datetime "used_time",                                        comment: "使用时间"
#   t.integer  "task_id",     limit: 4,  default: 0,               comment: "使用任务ID"
#   t.string   "batch_no",    limit: 12, default: "",              comment: "导出批次号"
#   t.integer  "updater_id",  limit: 4,  default: 0,               comment: "更新用户ID"
#   t.datetime "created_at",                          null: false
#   t.datetime "updated_at",                          null: false
# end
class LogisticOrder < ActiveRecord::Base
  belongs_to  :task
  belongs_to  :updater, class_name: "User"
end