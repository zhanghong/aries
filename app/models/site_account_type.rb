# create_table "account_types", force: :cascade do |t|
#   t.string   "type",        limit: 20,  default: "",                     comment: "种类"
#   t.integer  "platform_id", limit: 4,   default: 0,                      comment: "平台类型ID"
#   t.string   "name",        limit: 20,  default: "",                     comment: "类型名"
#   t.string   "image",       limit: 255, default: "",                     comment: "图片"
#   t.string   "icon_url",    limit: 150, default: "",                     comment: "icon图标URL"
#   t.integer  "limit_count", limit: 4,   default: 1,                      comment: "每个用户可绑定的数量"
#   t.string   "state",      limit: 20,  default: "actived",              comment: "状态"
#   t.integer  "updater_id",  limit: 4,   default: 0,                      comment: "编辑管理员"
#   t.datetime "deleted_at",                                               comment: "删除时间"
#   t.datetime "created_at",                                  null: false
#   t.datetime "updated_at",                                  null: false
# end
# add_index "account_types", ["platform_id", "name"], name: "idx_by_platform_id_and_name", using: :btree
class SiteAccountType < AccountType
  belongs_to  :platform
  has_many    :price_ranges
  has_many    :issues, class_name: "Issue", foreign_key: "account_type_id"

  MAX_BINDABLES = 3

  # 返回用户还可绑定的对象
  # ======== 参数 ===========
  # user_id(Integer) : 用户ID
  # ======== 返回值 ===========
  # return Array
  def self.find_user_bindables(user_id)
    self.join(:accounts).group("account_types.id")->having("COUNT(*) < #{MAX_BINDABLES}")
  end
end