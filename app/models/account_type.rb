# create_table "account_types", force: :cascade do |t|
#   t.string   "type",        limit: 20,  default: "",                     comment: "种类"
#   t.integer  "platform_id", limit: 4,   default: 0,                      comment: "平台类型ID"
#   t.string   "name",        limit: 20,  default: "",                     comment: "类型名"
#   t.string   "image",       limit: 255, default: "",                     comment: "图片"
#   t.string   "icon_url",    limit: 150, default: "",                     comment: "icon图标URL"
#   t.integer  "limit_count", limit: 4,   default: 1,                      comment: "每个用户可绑定的数量"
#   t.string   "status",      limit: 20,  default: "actived",              comment: "状态"
#   t.integer  "updater_id",  limit: 4,   default: 0,                      comment: "编辑管理员"
#   t.datetime "deleted_at",                                               comment: "删除时间"
#   t.datetime "created_at",                                  null: false
#   t.datetime "updated_at",                                  null: false
# end
# add_index "account_types", ["platform_id", "name"], name: "idx_by_platform_id_and_name", using: :btree
class AccountType < ActiveRecord::Base
  belongs_to  :platform
  belings_to  :updater, class_name: "User"
  has_many    :price_ranges
  has_many    :issues
  has_many    :accounts
end