# create_table "task_products", force: :cascade do |t|
#   t.integer  "task_id",           limit: 4,  default: 0,               comment: "关联task"
#   t.integer  "buyer_id",          limit: 4,  default: 0,               comment: "关联买手"
#   t.integer  "buyer_account_id",  limit: 4,  default: 0,               comment: "关联买手购买账号"
#   t.integer  "seller_id",         limit: 4,  default: 0,               comment: "关联商家"
#   t.integer  "seller_account_id", limit: 4,  default: 0,               comment: "关联商家店铺账号"
#   t.string   "outer_product_id",  limit: 30, default: "",              comment: "外部商品ID"
#   t.date     "expire_on",                                              comment: "过期日期"
#   t.datetime "created_at",                                null: false
#   t.datetime "updated_at",                                null: false
# end
# add_index "task_products", ["buyer_id", "buyer_account_id", "seller_id", "seller_account_id"], name: "idx_by_byid_and_buyer_account_id_and_slid_seller_account_id", using: :btree
class TaskProduct < ActiveRecord::Base
  belongs_to  :task
  belongs_to  :buyer, class_name: "User"
  belongs_to  :buyer_account, class_name: "account"
  belongs_to  :seller,  class_name: "User"
  belongs_to  :seller_account,  class_name: "account"
end