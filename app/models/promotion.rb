# create_table "promotions", force: :cascade do |t|
#   t.integer  "user_id",         limit: 4,                           default: 0,                comment: "所属用户ID"
#   t.string   "promotion_type",  limit: 30,                          default: "",               comment: "推广类型"
#   t.integer  "related_user_id", limit: 4,                           default: 0,                comment: "触发推广事件用户ID"
#   t.decimal  "actived_point",               precision: 8, scale: 2, default: 0.0,              comment: "所获得的可用爆点"
#   t.string   "memo",            limit: 100,                         default: "",               comment: "备注信息"
#   t.datetime "created_at",                                                        null: false
#   t.datetime "updated_at",                                                        null: false
# end
# add_index "promotions", ["user_id", "promotion_type"], name: "idx_by_user_id_and_promotion_type", using: :btree
class Promotion < ActiveRecord::Base
  belongs_to  :user
end