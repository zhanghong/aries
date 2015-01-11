# create_table "tasks", force: :cascade do |t|
#   t.integer  "issue_id",                    limit: 4,                            default: 0,                      comment: "所属商家发布任务"
#   t.integer  "parent_issue_id",             limit: 4,                            default: 0,                      comment: "所属商家发布任务组"
#   t.integer  "platform_id",                 limit: 4,                            default: 0,                      comment: "平台类型ID"
#   t.integer  "seller_id",                   limit: 4,                            default: 0,                      comment: "商家ID"
#   t.integer  "buyer_id",                    limit: 4,                            default: 0,                      comment: "买手id"
#   t.integer  "seller_account_id",           limit: 4,                            default: 0,                      comment: "商家发布任务店铺ID"
#   t.integer  "buyer_account_id",            limit: 4,                            default: 0,                      comment: "买手使用的账号ID"
#   t.string   "serial_no",                   limit: 30,                           default: "",                     comment: "任务编号"
#   t.string   "outer_serial_no",             limit: 30,                           default: "",                     comment: "外部平台的订单ID"
#   t.string   "terminal_type",               limit: 255,                          default: "",                     comment: "终端类型"
#   t.string   "task_type",                   limit: 30,                           default: "",                     comment: "任务类型"
#   t.string   "status",                      limit: 30,                           default: "pinding",              comment: "当前状态"
#   t.datetime "pay_expired_at",                                                                                    comment: "付款过期时间"
#   t.datetime "refund_expired_at",                                                                                 comment: "商家退款最晚时间"
#   t.integer  "refund_account_id",           limit: 4,                            default: 0,                      comment: "退款账号ID"
#   t.string   "refund_account_name",         limit: 50,                           default: "",                     comment: "退款账号名"
#   t.string   "refund_account_receive_name", limit: 50,                           default: "",                     comment: "退款账号的用户名"
#   t.string   "sub_status",                  limit: 30,                           default: "pinding",              comment: "子状态"
#   t.decimal  "locked_point",                            precision: 5,  scale: 2, default: 0.0,                    comment: "买手接任务时扣的爆点"
#   t.decimal  "seller_base_point",                       precision: 5,  scale: 2, default: 0.0,                    comment: "每单商家支付的基本爆点费用"
#   t.decimal  "seller_add_point",                        precision: 5,  scale: 2, default: 0.0,                    comment: "每单商家支付的悬赏爆点费用"
#   t.decimal  "seller_all_point",                        precision: 5,  scale: 2, default: 0.0,                    comment: "每单商家支付的所有爆点"
#   t.decimal  "buyer_base_point",                        precision: 5,  scale: 2, default: 0.0,                    comment: "每单买手得到的基本爆点"
#   t.decimal  "buyer_add_point",                         precision: 5,  scale: 2, default: 0.0,                    comment: "每单买手得到的悬赏爆点"
#   t.decimal  "buyer_all_point",                         precision: 5,  scale: 2, default: 0.0,                    comment: "每单买手得到的总爆点"
#   t.string   "point_status",                limit: 20,                           default: "locked",               comment: "爆点返还状态"
#   t.string   "payment_type",                limit: 30,                           default: "",                     comment: "付款类型"
#   t.decimal  "payment_price",                           precision: 10, scale: 2, default: 0.0,                    comment: "买手实付金额"
#   t.integer  "receive_area_id",             limit: 4,                            default: 0,                      comment: "收货人所在地区"
#   t.string   "receive_area_name",           limit: 100,                          default: "",                     comment: "收货人所在地区名"
#   t.string   "receive_address",             limit: 255,                          default: "",                     comment: "收货人详细地址"
#   t.string   "receive_name",                limit: 30,                           default: "",                     comment: "收货人名"
#   t.string   "receive_phone",               limit: 30,                           default: "",                     comment: "收货人手机"
#   t.string   "logistic_serial_no",          limit: 20,                           default: "",                     comment: "物流单号"
#   t.string   "logistic_compay_code",        limit: 6,                            default: "",                     comment: "物流公司编号"
#   t.integer  "buyer_integral",              limit: 4,                            default: 0,                      comment: "买手做完任务获得的经验值（积分）"
#   t.integer  "updater_id",                  limit: 4,                            default: 0,                      comment: "更新用户ID"
#   t.datetime "created_at",                                                                           null: false
#   t.datetime "updated_at",                                                                           null: false
# end
# add_index "tasks", ["buyer_id", "buyer_account_id", "serial_no"], name: "idx_by_buyer_id_buyer_account_id_and_serial_no", using: :btree
# add_index "tasks", ["parent_issue_id", "issue_id"], name: "idx_by_parent_issue_id_and_issue_id", using: :btree
# add_index "tasks", ["seller_id", "seller_account_id", "serial_no"], name: "idx_by_seller_id_seller_account_id_and_serial_no", using: :btree
# add_index "tasks", ["serial_no"], name: "idx_by_serial_no", using: :btree
class Task < ActiveRecord::Base
  belongs_to  :platform
  belongs_to  :issue
  belongs_to  :parent_issue,  class_name: "Issue"
  belongs_to  :seller,  class_name: "User"
  belongs_to  :buyer, class_name: "User"
  belongs_to  :seller_account,  class_name: "Account"
  belongs_to  :buyer_account, class_name: "Account"
  belongs_to  :updater, class_name: "User"

  has_many  :task_properties
  has_many  :task_products
  has_many  :task_logs
  has_many  :logistic_orders
end