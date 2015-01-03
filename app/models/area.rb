# create_table "areas", force: :cascade do |t|
#   t.integer  "taobao_id",  limit: 4,  default: 0,               comment: "对应淘宝ID"
#   t.string   "name",       limit: 30, default: "",              comment: "省/市/区名称"
#   t.integer  "parent_id",  limit: 4,  default: 0,               comment: "父级名称"
#   t.string   "pinyin",     limit: 10, default: "",              comment: "拼音简写"
#   t.string   "zipcode",    limit: 8,  default: "",              comment: "邮编"
#   t.integer  "updater_id", limit: 4,  default: 0,               comment: "更新管理员ID"
#   t.datetime "deleted_at",                                      comment: "删除时间"
#   t.datetime "created_at",                         null: false
#   t.datetime "updated_at",                         null: false
# end
# add_index "areas", ["parent_id", "name"], name: "idx_by_parent_id_and_name", using: :btree
class Area < ActiveRecord::Base
  has_many  :users
  has_many  :accounts
end