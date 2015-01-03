# create_table "cash_logs", force: :cascade do |t|
#   t.string   "serial_no",             limit: 30,                           default: "",               comment: "任务编号"
#   t.string   "flow_type",             limit: 40,                           default: "",               comment: "流水类型"
#   t.string   "status",                limit: 20,                           default: "",               comment: "状态"
#   t.integer  "source_id",             limit: 4,                            default: 0,                comment: "资金来源用户ID"
#   t.integer  "target_id",             limit: 4,                            default: 0,                comment: "资金去向用户ID"
#   t.decimal  "actived_cash",                      precision: 10, scale: 2,                            comment: "可用押金/本金流水"
#   t.decimal  "locked_cash",                       precision: 12, scale: 2,                            comment: "冻结押金/本金流水"
#   t.decimal  "actived_point",                     precision: 10, scale: 2,                            comment: "可用爆点流水"
#   t.decimal  "locked_point",                      precision: 12, scale: 2,                            comment: "冻结爆点流水"
#   t.decimal  "current_actived_cash",              precision: 12, scale: 2, default: 0.0,              comment: "流水结算后的可用押金/本金"
#   t.decimal  "current_locked_cash",               precision: 12, scale: 2, default: 0.0,              comment: "流水结算后的冻结押金/本金"
#   t.decimal  "current_actived_point",             precision: 12, scale: 2, default: 0.0,              comment: "流水结算后的可用爆点"
#   t.decimal  "current_locked_point",              precision: 12, scale: 2, default: 0.0,              comment: "流水结算后的冻结爆点"
#   t.string   "related_type",          limit: 30,                           default: "",               comment: "关联对象类型"
#   t.integer  "related_id",            limit: 4,                            default: 0,                comment: "关联对象ID"
#   t.string   "memo",                  limit: 255,                          default: "",               comment: "备注"
#   t.integer  "operater_id",           limit: 4,                            default: 0,                comment: "操作用户ID"
#   t.datetime "created_at",                                                               null: false
#   t.datetime "updated_at",                                                               null: false
# end
# add_index "cash_logs", ["target_id", "flow_type"], name: "idx_by_target_id_and_flow_type", using: :btree
class CashLog < ActiveRecord::Base
  belongs_to  :source_user, class_name: "User", foreign_key: "source_id"
  belongs_to  :target_user, class_name: "User", foreign_key: "target_id"
  belongs_to  :operater_user, class_name: "User", foreign_key: "operater_id"
end