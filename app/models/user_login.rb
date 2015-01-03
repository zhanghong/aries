# create_table "user_logins", force: :cascade do |t|
#   t.string   "user_id",      limit: 255, default: "0",              comment: "用户ID"
#   t.string   "user_agent",   limit: 255, default: "",               comment: "浏览器信息"
#   t.string   "sign_in_ip",   limit: 16,  default: "",               comment: "访问IP"
#   t.string   "sign_in_area", limit: 30,  default: "",               comment: "登录地区"
#   t.datetime "created_at",                             null: false
#   t.datetime "updated_at",                             null: false
# end
# add_index "user_logins", ["user_id"], name: "idx_by_user_id", using: :btree
class UserLogin < ActiveRecord::Base
  belongs_to  :user
end