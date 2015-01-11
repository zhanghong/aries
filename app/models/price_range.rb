# create_table "price_ranges", force: :cascade do |t|
#   t.integer  "account_type_id", limit: 4,                          default: 0,                comment: "平台类型"
#   t.string   "task_type",       limit: 30,                         default: "",               comment: "任务类型"
#   t.integer  "gte_price",       limit: 4,                          default: 0,                comment: "价格档起始金额"
#   t.integer  "lte_price",       limit: 4,                          default: 0,                comment: "价格档结束金额"
#   t.decimal  "seller_point",               precision: 5, scale: 2, default: 0.0,              comment: "商家付的爆点值"
#   t.decimal  "buyer_point",                precision: 5, scale: 2, default: 0.0,              comment: "买手得到的爆点值"
#   t.decimal  "stytem_point",               precision: 5, scale: 2, default: 0.0,              comment: "平台费用"
#   t.integer  "updater_id",      limit: 4,                          default: 0,                comment: "编辑管理员"
#   t.datetime "deleted_at",                                                                    comment: "删除时间"
#   t.datetime "created_at",                                                       null: false
#   t.datetime "updated_at",                                                       null: false
# end
# add_index "price_ranges", ["account_type_id", "task_type"], name: "idx_by_account_type_id_and_task_type", using: :btree
class PriceRange < ActiveRecord::Base
  belongs_to  :account_type
  belongs_to  :updater, class_name: "User"
end