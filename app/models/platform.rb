# create_table "platforms", force: :cascade do |t|
#   t.string   "name",       limit: 30,  default: "",              comment: "平台名"
#   t.string   "image",      limit: 255, default: "",              comment: "图片"
#   t.integer  "updater_id", limit: 4,   default: 0,               comment: "更新用户"
#   t.datetime "deleted_at",                                       comment: "删除时间"
#   t.datetime "created_at",                          null: false
#   t.datetime "updated_at",                          null: false
# end
class Platform < ActiveRecord::Base
  has_many  :tasks
  has_many  :issues
  has_many  :account_types
  has_many  :accounts

  before_save :set_updater_id
  before_update :set_updater_id

  MAX_BINDED_COUNT = 3

  # 用户可绑定账号的平台类型
  def self.bindable(user)
    return self.join(:accounts).where(["accounts.user_id = ?", user.id]).
                group("platforms.id").having("COUNT(*) < #{MAX_BINDED_COUNT}").all
  end
private
  # 设置更新用户ID
  def set_updater_id
    self.updater_id = User.current_id
  end
end