# create_table "task_properties", force: :cascade do |t|
#   t.integer  "task_id",           limit: 4,                         default: 0,              comment: "关联task"
#   t.integer  "property_range_id", limit: 4,                         default: 0,              comment: "关联分布任务"
#   t.decimal  "per_point",                   precision: 5, scale: 2,                          comment: "额外价格"
#   t.datetime "created_at",                                                      null: false
#   t.datetime "updated_at",                                                      null: false
# end
# add_index "task_properties", ["task_id"], name: "idx_by_task_id_and_property_range_id", using: :btree
class TaskProperty < ActiveRecord::Base
  belongs_to  :task
  belongs_to  :property_range
end