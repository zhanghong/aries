# create_table "accounts", force: :cascade do |t|
#   t.integer  "user_id",         limit: 4,   default: 0,                      comment: "关联用户"
#   t.integer  "account_type_id", limit: 4,   default: 0,                      comment: "关联账号类型"
#   t.string   "type",            limit: 30,  default: "",                     comment: "账号类型"
#   t.integer  "platform_id",     limit: 4,   default: 0,                      comment: "平台类型ID"
#   t.string   "name",            limit: 50,  default: "",                     comment: "账号名"
#   t.string   "sub_name",        limit: 50,  default: "",                     comment: "账号辅助名，如银行卡的开户支行名，淘宝店铺掌柜ID"
#   t.string   "user_name",       limit: 30,  default: ""
#   t.string   "user_phone",      limit: 15,  default: ""
#   t.string   "status",          limit: 20,  default: "pinding",              comment: "状态"
#   t.integer  "area_id",         limit: 4,   default: 0,                      comment: "收货地区"
#   t.string   "area_name",       limit: 100, default: "",                     comment: "所在地区名"
#   t.string   "home_page",       limit: 255, default: "",                     comment: "首页URL"
#   t.string   "address",         limit: 255, default: "",                     comment: "收货地址"
#   t.string   "zipcode",         limit: 8,   default: "",                     comment: "邮编"
#   t.integer  "upload_id",       limit: 4,   default: 0,                      comment: "附件ID"
#   t.string   "memo",            limit: 255, default: "",                     comment: "备注"
#   t.string   "failed_reason",   limit: 255, default: "",                     comment: "审核失败原因"
#   t.integer  "updater_id",      limit: 4,   default: 0,                      comment: "更新用户ID"
#   t.datetime "deleted_at",                                                   comment: "删除时间"
#   t.datetime "created_at",                                      null: false
#   t.datetime "updated_at",                                      null: false
# end
# add_index "accounts", ["type", "user_id", "account_type_id"], name: "idx_by_type_user_id_and_account_type", using: :btree
# add_index "accounts", ["type", "user_id", "platform_id"], name: "idx_by_type_user_id_and_platform_id", using: :btree
class TenpayAccount < ActiveRecord::Base
  validates :sub_name, presence: true, length: {maximum: 50}
  validates :picture, presence: true
end