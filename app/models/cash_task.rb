# create_table "cash_tasks", force: :cascade do |t|
#   t.string   "serial_no",        limit: 30,                           default: "",                     comment: "任务编号"
#   t.integer  "user_id",          limit: 4,                            default: 0,                      comment: "提现用户"
#   t.string   "type",             limit: 40,                           default: "",                     comment: "现金流向"
#   t.string   "status",           limit: 20,                           default: "pinding",              comment: "状态"
#   t.decimal  "actived_cash",                 precision: 12, scale: 2, default: 0.0,                    comment: "充值或调整可用押金"
#   t.decimal  "actived_point",                precision: 12, scale: 2, default: 0.0,                    comment: "调整可用爆点"
#   t.decimal  "commission_cash",              precision: 10, scale: 2, default: 0.0,                    comment: "任务押金手续费"
#   t.decimal  "real_cash",                    precision: 12, scale: 2, default: 0.0,                    comment: "任务实际到账押金"
#   t.decimal  "commission_point",             precision: 10, scale: 2, default: 0.0,                    comment: "任务爆点手续费"
#   t.decimal  "real_point",                   precision: 12, scale: 2, default: 0.0,                    comment: "任务实际到账爆点"
#   t.string   "memo",             limit: 255,                          default: "",                     comment: "备注"
#   t.integer  "updater_id",       limit: 4,                            default: 0,                      comment: "更新用户"
#   t.datetime "created_at",                                                                null: false
#   t.datetime "updated_at",                                                                null: false
# end

# add_index "cash_tasks", ["serial_no"], name: "idx_by_serial_no", using: :btree
# add_index "cash_tasks", ["type", "user_id", "serial_no"], name: "idx_by_type_user_id_and_serial_no", using: :btree
class CashTask < ActiveRecord::Base
  belongs_to  :user
  belings_to  :updater, class_name: "User"
end