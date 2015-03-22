# create_table "payment_orders", force: :cascade do |t|
#   t.integer  "user_id",          limit: 4,                            default: 0,                      comment: "关联用户iD"
#   t.string   "related_type",     limit: 30,                           default: "",                     comment: "关联任务类型"
#   t.integer  "related_id",       limit: 4,                            default: 0,                      comment: "关联任务iD"
#   t.string   "flow_type",        limit: 30,                           default: "",                     comment: "订单类型"
#   t.string   "status",           limit: 20,                           default: "pinding",              comment: "状态"
#   t.string   "related_status",   limit: 30,                           default: "",                     comment: "关联对象状态更新结果"
#   t.string   "first_use",        limit: 255,                          default: "point",                comment: "优先使用类型"
#   t.decimal  "unit_cash",                    precision: 12, scale: 2, default: 0.0,                    comment: "购买商品单价（押金）"
#   t.decimal  "unit_point",                   precision: 12, scale: 2, default: 0.0,                    comment: "购买商品单价（爆点）"
#   t.integer  "number",           limit: 4,                            default: 0,                      comment: "购买数量"
#   t.decimal  "total_cash",                   precision: 12, scale: 2, default: 0.0,                    comment: "应付押金总数"
#   t.decimal  "total_point",                  precision: 12, scale: 2, default: 0.0,                    comment: "应付爆点总数"
#   t.decimal  "discount_cash",                precision: 12, scale: 2, default: 0.0,                    comment: "优惠押金"
#   t.decimal  "discount_point",               precision: 12, scale: 3, default: 0.0,                    comment: "优惠爆点"
#   t.decimal  "commission_point",             precision: 12, scale: 4, default: 0.0,                    comment: "系统服务费爆点"
#   t.decimal  "real_cash",                    precision: 12, scale: 5, default: 0.0,                    comment: "实付押金"
#   t.decimal  "real_point",                   precision: 12, scale: 6, default: 0.0,                    comment: "实付爆点"
#   t.decimal  "inner_cash",                   precision: 12, scale: 2, default: 0.0,                    comment: "使用可用押金支付金额"
#   t.decimal  "inner_point",                  precision: 12, scale: 2, default: 0.0,                    comment: "使用可用爆点支付数量"
#   t.decimal  "outer_cash",                   precision: 12, scale: 2, default: 0.0,                    comment: "使用第三方平台支付金额"
#   t.decimal  "outer_point",                  precision: 12, scale: 2, default: 0.0,                    comment: "使用第三方平台支付爆点数量"
#   t.datetime "pay_expired_at",                                                                         comment: "支付过期时间"
#   t.string   "memo",             limit: 100,                          default: "",                     comment: "订单备注"
#   t.string   "result_info",      limit: 100,                          default: "",                     comment: "支付结果信息"
#   t.datetime "created_at",                                                                null: false
#   t.datetime "updated_at",                                                                null: false
# end
# add_index "payment_orders", ["user_id", "related_type", "related_id"], name: "idx_by_user_id_and_related_type_and_related_id", using: :btree
class PaymentOrder < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :user_info, foreign_key: "user_id"

  # 订单支付有效时间（秒）
  ACTIVED_SECONDS = 1200;

  validates :user_id, presence: true
  validates :related_type, presence: true
  validates :related_id, presence: true
  validates :flow_type, presence: true
  validates :number,
            :presence => true,
            :numericality => {greater_than: 0}
  validates :pay_expired_at, presence: true
  validates :real_point, presence: true, :if => Proc.new { |p| p.real_cash.blank? }

  before_save :set_auto_fields

  state_machine :state, :initial => :pinding do
    
  end

private
  def set_auto_fields
    self.total_cash = self.number * self.unit_cash
    self.total_point = self.number * self.unit_point
    self.real_cash = self.total_cash - self.discount_cash
    self.real_point = self.total_point - self.discount_point
  end
end