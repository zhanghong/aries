# create_table "weibo_orders", force: :cascade do |t|
#   t.integer  "user_id",    limit: 4,                           default: 0,                      comment: "所属用户ID"
#   t.string   "status",     limit: 20,                          default: "pinding",              comment: "订单状态"
#   t.string   "paied_type", limit: 50,                          default: "",                     comment: "支付对象类型"
#   t.integer  "paied_id",   limit: 4,                           default: 0,                      comment: "支付对象ID"
#   t.string   "event_name", limit: 30,                          default: "",                     comment: "支付事件名"
#   t.decimal  "amount",                precision: 12, scale: 2,                                  comment: "支付金额"
#   t.datetime "expired_at",                                                                      comment: "支付过期时间"
#   t.datetime "created_at",                                                         null: false
#   t.datetime "updated_at",                                                         null: false
# end
# add_index "weibo_orders", ["user_id", "paied_type", "paied_id"], name: "idx_by_user_id_and_paied_type_and_paied_id", using: :btree
class WeiboOrder < ActiveRecord::Base
  belongs_to  :user
  has_many  :weibo_notifies
end