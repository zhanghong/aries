# create_table "account_logs", force: :cascade do |t|
#     t.integer  "account_id", limit: 4,   default: 0,               comment: "关联账号ID"
#     t.string   "status",     limit: 20,  default: "",              comment: "状态"
#     t.string   "memo",       limit: 255, default: "",              comment: "备注"
#     t.integer  "updater_id", limit: 4,   default: 0,               comment: "更新用户ID"
#     t.datetime "created_at",                          null: false
#     t.datetime "updated_at",                          null: false
#   end
#   add_index "account_logs", ["account_id"], name: "idx_by_account_id", using: :btree
class AccountLog < ActiveRecord::Base
  belongs_to  :account
  belongs_to  :updater,   class_name: "User"

private
  # 设置更新用户ID
  def set_updater_id
    self.updater_id = User.current_id
  end
end