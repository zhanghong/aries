# create_table "users", force: :cascade do |t|
#   t.string   "name",                   limit: 50,  default: ""
#   t.string   "email",                  limit: 100, default: "", null: false
#   t.string   "phone",                  limit: 30,  default: "",              comment: "手机号码"
#   t.string   "qq",                     limit: 30,  default: "",              comment: "QQ号码"
#   t.string   "wangwang",               limit: 30,  default: "",              comment: "旺旺号码"
#   t.string   "from_type",              limit: 10,  default: "",              comment: "注册来源"
#   t.string   "type",                   limit: 10,  default: "",              comment: "用户类型"
#   t.string   "avatar",                 limit: 255, default: "",              comment: "用户头像"
#   t.string   "gender",                 limit: 255, default: "",              comment: "用户性别"
#   t.date     "born_on",                                                      comment: "出生日期"
#   t.integer  "area_id",                limit: 4,   default: 0,               comment: "所在地区ID"
#   t.string   "area_name",              limit: 100, default: "",              comment: "所在地区名"
#   t.string   "encrypted_password",     limit: 255, default: "", null: false
#   t.string   "encrypted_pay_password", limit: 255, default: "",              comment: "支付密码"
#   t.integer  "alipay_account_id",      limit: 4,   default: 0,               comment: "支付宝账号ID"
#   t.integer  "tenpay_account_id",      limit: 4,   default: 0,               comment: "财富通账号ID"
#   t.integer  "bank_account_id",        limit: 4,   default: 0,               comment: "银行卡账号ID"
#   t.string   "invitation_code",        limit: 10,  default: "",              comment: "邀请码"
#   t.string   "invitater_name",         limit: 30,  default: "",              comment: "邀请用户名"
#   t.integer  "invitator_id",           limit: 4,   default: 0,               comment: "邀请用户ID"
#   t.integer  "vip_months",             limit: 4,   default: 0,               comment: "用户累计开通VIP多少个月"
#   t.date     "expired_on",                                                   comment: "账户过期时间"
#   t.datetime "freezed_at",                                                   comment: "账户冻结时间"
#   t.string   "freezed_reason",         limit: 255, default: "",              comment: "账户冻结原因"
#   t.string   "freezed_memo",           limit: 255, default: "",              comment: "账户冻结备注"
#   t.integer  "freezer_id",             limit: 4,                             comment: "冻结操作管理员"
#   t.string   "reset_password_token",   limit: 255
#   t.datetime "reset_password_sent_at"
#   t.datetime "remember_created_at"
#   t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
#   t.datetime "current_sign_in_at"
#   t.datetime "last_sign_in_at"
#   t.string   "current_sign_in_ip",     limit: 255
#   t.string   "last_sign_in_ip",        limit: 255
#   t.string   "last_sign_in_area",      limit: 50,  default: "",              comment: "上次登录地区"
#   t.string   "current_sign_in_area",   limit: 50,  default: "",              comment: "本次登录地区"
#   t.string   "confirmation_token",     limit: 255
#   t.datetime "confirmed_at"
#   t.datetime "confirmation_sent_at"
#   t.string   "unconfirmed_email",      limit: 255
#   t.integer  "failed_attempts",        limit: 4,   default: 0,  null: false
#   t.string   "unlock_token",           limit: 255
#   t.datetime "locked_at"
#   t.datetime "created_at"
#   t.datetime "updated_at"
# end
# add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
# add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
# add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
# add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to  :area
  belongs_to  :alipay_account,  class_name: "Account"
  belongs_to  :tenpay_account,  class_name: "Account"
  belongs_to  :bank_account,  class_name: "Account"
  belongs_to  :invitator,   class_name: "User"
  belongs_to  :freezer, class_name: "User"

  has_one   :user_info, foreign_key: "id"
  has_many  :user_logins
  has_many  :weibo_orders
  has_many  :invitated_users,  class_name: "User", foreign_key: "invitator_id"
  has_many  :buyer_task_products, class_name: "TaskProduct", foreign_key: "buyer_id"
  has_many  :seller_task_products, class_name: "TaskProduct", foreign_key: "seller_id"
  has_many  :seller_tasks,  class_name: "Task", foreign_key: "seller_id"
  has_many  :buyer_tasks,   class_name: "Task", foreign_key: "buyer_id"
  has_many  :promotions
  has_many  :payment_orders
  has_many  :messages
  has_many  :issues
  has_many  :downloads
  has_many  :download_logs
  has_many  :cash_tasks
  has_many  :source_cash_logs,  class_name: "CashLog",  foreign_key: "source_id"
  has_many  :target_cash_logs,  class_name: "CashLog",  foreign_key: "target_id"
  has_many  :operated_cash_logs,  class_name: "CashLog",  foreign_key: "operater_id"
end