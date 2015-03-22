# create_table "areas", force: :cascade do |t|
#   t.integer  "taobao_id",      limit: 4,  default: 0,               comment: "对应淘宝ID"
#   t.string   "name",           limit: 30, default: "",              comment: "省/市/区名称"
#   t.integer  "parent_id",      limit: 4,  default: 0,               comment: "父级名称"
#   t.string   "pinyin",         limit: 10, default: "",              comment: "拼音简写"
#   t.integer  "children_count", limit: 4,  default: 0
#   t.integer  "lft",            limit: 4,  default: 0
#   t.integer  "rgt",            limit: 4,  default: 0
#   t.integer  "depth",          limit: 4,  default: 0
#   t.string   "zipcode",        limit: 8,  default: "",              comment: "邮编"
#   t.integer  "updater_id",     limit: 4,  default: 0,               comment: "更新管理员ID"
#   t.datetime "deleted_at",                                          comment: "删除时间"
#   t.datetime "created_at",                             null: false
#   t.datetime "updated_at",                             null: false
# end
# add_index "areas", ["parent_id", "name"], name: "idx_by_parent_id_and_name", using: :btree
class Area < ActiveRecord::Base
  acts_as_nested_set counter_cache: :children_count
  has_many  :users
  has_many  :accounts

  # self_and_ancestors 当前对象和它的所有父结点
  # descendants 当前对象所有父结点
  # self_and_ancestors 当前对象和它的所有子结点
  # ancestors 当前对象的所有子结点

  def is_leaf?
    children.count == 0
  end

  def full_name
    self.ftq.self_and_ancestors.map(&:name).join(" ")
  end
private
  def self.set_level_id(area, level_id)
    area.update(level_id: level_id)
    area.children.each do |child|
      set_level_id(child, level_id + 1)
    end
  end
end