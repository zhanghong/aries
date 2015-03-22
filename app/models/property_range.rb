# create_table "property_ranges", force: :cascade do |t|
#   t.integer  "issue_id",    limit: 4,                           default: 0,               comment: "所属任务"
#   t.string   "name",        limit: 255,                         default: "",              comment: "属性名"
#   t.string   "content",     limit: 255,                         default: "",              comment: "属性值"
#   t.string   "memo",        limit: 255,                         default: "",              comment: "属性值辅助"
#   t.integer  "need_number", limit: 4,                           default: 0,               comment: "分配的task数量"
#   t.integer  "did_number",  limit: 4,                           default: 0,               comment: "已开始task数量"
#   t.decimal  "per_point",               precision: 5, scale: 2,                           comment: "每单额外价格"
#   t.datetime "created_at",                                                   null: false
#   t.datetime "updated_at",                                                   null: false
# end
# add_index "property_ranges", ["issue_id"], name: "idx_by_issue_id", using: :btree
class PropertyRange < ActiveRecord::Base
  belongs_to  :issue
  has_many  :task_properties
end