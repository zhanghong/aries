# create_table "weibo_notifies", force: :cascade do |t|
#   t.integer  "weibo_order_id",      limit: 4,                              default: 0,                comment: "所属微博订单"
#   t.string   "merchant_account_id", limit: 40,                             default: "",               comment: "人民币账号"
#   t.string   "version",             limit: 10,                             default: "0",              comment: "网关版本"
#   t.string   "language",            limit: 2,                              default: "",               comment: "网页显示语言"
#   t.integer  "sign_type",           limit: 4,                              default: 0,                comment: "签名类型"
#   t.string   "pay_type",            limit: 2,                              default: "",               comment: "支付方式"
#   t.string   "bank_id",             limit: 8,                              default: "",               comment: "银行代码"
#   t.datetime "order_time",                                                                            comment: "订单提交时间"
#   t.decimal  "order_amount",                      precision: 12, scale: 2,                            comment: "订单金额"
#   t.string   "deal_id",             limit: 30,                             default: "",               comment: "新浪支付交易号"
#   t.string   "bank_deal_id",        limit: 30,                             default: "",               comment: "银行交易号"
#   t.datetime "deal_time",                                                                             comment: "在新浪支付成功的时间"
#   t.decimal  "pay_amount",                        precision: 12, scale: 2,                            comment: "订单实付金额"
#   t.decimal  "fee",                               precision: 12, scale: 2,                            comment: "费用"
#   t.string   "ext1",                limit: 128,                            default: "",               comment: "扩展字段1"
#   t.string   "ext2",                limit: 128,                            default: "",               comment: "扩展字段2"
#   t.integer  "pay_result",          limit: 4,                              default: 0,                comment: "处理结果"
#   t.string   "pay_ip",              limit: 15,                             default: "",               comment: "在网银的支付IP"
#   t.string   "err_code",            limit: 10,                             default: "",               comment: "错误代码"
#   t.text     "sign_msg",            limit: 65535,                                                     comment: "签名字符串"
#   t.datetime "created_at",                                                               null: false
#   t.datetime "updated_at",                                                               null: false
# end
# add_index "weibo_notifies", ["weibo_order_id"], name: "idx_by_weibo_order_id", using: :btree
class WeiboNotify < ActiveRecord::Base
  belongs_to  :weibo_order
end