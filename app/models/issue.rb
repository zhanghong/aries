# create_table "issues", force: :cascade do |t|
#   t.integer  "user_id",            limit: 4,                              default: 0,                      comment: "关联商家用户"
#   t.integer  "platform_id",        limit: 4,                              default: 0,                      comment: "平台类型ID"
#   t.integer  "account_type_id",    limit: 4,                              default: 0,                      comment: "账号类型ID"
#   t.integer  "account_id",         limit: 4,                              default: 0,                      comment: "所属账号"
#   t.integer  "parent_id",          limit: 4,                              default: 0,                      comment: "父级任务ID"
#   t.string   "serial_no",          limit: 30,                             default: "",                     comment: "项目编号"
#   t.string   "issue_type",         limit: 30,                             default: "",                     comment: "任务类型"
#   t.string   "task_type",          limit: 255,                            default: "",                     comment: "任务类型"
#   t.string   "post_type",          limit: 255,                            default: "pay",                  comment: "邮费类型"
#   t.integer  "total_number",       limit: 4,                              default: 1,                      comment: "总刷单数量"
#   t.integer  "unit_product_count", limit: 4,                              default: 0,                      comment: "每单购买的商品件数"
#   t.decimal  "unit_price",                       precision: 10, scale: 2, default: 0.0,                    comment: "每单的单价"
#   t.decimal  "unit_insurance",                   precision: 10, scale: 2, default: 0.0,                    comment: "每单扣除的保险金"
#   t.decimal  "unit_postage",                     precision: 5,  scale: 2, default: 0.0,                    comment: "每单扣除的邮费"
#   t.integer  "pc_number",          limit: 4,                              default: 0,                      comment: "电脑刷单量"
#   t.integer  "pc_did_number",      limit: 4,                              default: 0,                      comment: "电脑已完成或正在刷单量"
#   t.integer  "mobile_number",      limit: 4,                              default: 0,                      comment: "手机/pad刷单量"
#   t.integer  "mobile_did_number",  limit: 4,                              default: 0,                      comment: "手机/pad已完成刷单量"
#   t.text     "comment_list",       limit: 65535,                                                           comment: "卖家给的备注模板"
#   t.decimal  "seller_base_point",                precision: 5,  scale: 2, default: 0.0,                    comment: "每单商家支付的基本爆点费用"
#   t.decimal  "seller_add_point",                 precision: 5,  scale: 2, default: 0.0,                    comment: "每单商家支付的悬赏爆点费用"
#   t.decimal  "seller_all_point",                 precision: 5,  scale: 2, default: 0.0,                    comment: "每单商家支付的所有爆点"
#   t.decimal  "buyer_base_point",                 precision: 5,  scale: 2, default: 0.0,                    comment: "每单买手得到的基本爆点"
#   t.decimal  "buyer_add_point",                  precision: 5,  scale: 2, default: 0.0,                    comment: "每单买手得到的悬赏爆点"
#   t.decimal  "buyer_point",                      precision: 5,  scale: 2, default: 0.0,                    comment: "每单买手得到的总爆点"
#   t.decimal  "locked_deposit",                   precision: 10, scale: 2, default: 0.0,                    comment: "冻结的押金"
#   t.decimal  "locked_insurance",                 precision: 10, scale: 2, default: 0.0,                    comment: "冻结的保险金"
#   t.decimal  "locked_postage",                   precision: 10, scale: 2, default: 0.0,                    comment: "冻结的邮费"
#   t.decimal  "locked_point",                     precision: 10, scale: 2, default: 0.0,                    comment: "冻结爆点"
#   t.decimal  "commission_point",                 precision: 10, scale: 2, default: 0.0,                    comment: "发布任务的平台佣金爆点"
#   t.string   "status",             limit: 20,                             default: "pinding",              comment: "任务状态"
#   t.string   "point_status",       limit: 20,                             default: "locked",               comment: "爆点返还状态"
#   t.string   "failed_reason",      limit: 100,                            default: "",                     comment: "审核失败原因"
#   t.boolean  "is_priority",        limit: 1,                              default: false,                  comment: "是否优先排列"
#   t.integer  "template_id",        limit: 4,                              default: 0,                      comment: "模板ID"
#   t.integer  "updater_id",         limit: 4,                              default: 0,                      comment: "更新用户ID"
#   t.datetime "created_at",                                                                    null: false
#   t.datetime "updated_at",                                                                    null: false
# end
# add_index "issues", ["platform_id", "account_type_id", "parent_id"], name: "idx_by_platform_account_type_id_and_parent_id", using: :btree
# add_index "issues", ["user_id", "account_id"], name: "idx_by_user_id_and_account_id", using: :btree
class Issue < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :platform
  belongs_to  :account_type
  belongs_to  :parent,  class_name: "Issue"
  belongs_to  :template,  class_name: "Issue"
  
  has_many    :tasks
  has_many    :property_ranges
  has_many    :products
  has_many    :issue_services
  has_many    :issue_schedulers
  has_many    :issue_logs
  has_many    :children,  class_name: "Issue",  foreign_key: "parent_id"
  has_many    :template_children, class_name: "Issue", foreign_key: "template_id"
  has_many    :all_tasks, class_name: "Task", foreign_key: "parent_issue_id"
 
end