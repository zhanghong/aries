# create_table "products", force: :cascade do |t|
#   t.integer  "issue_id",          limit: 4,                             default: 0,               comment: "所属任务"
#   t.string   "name",              limit: 100,                           default: "",              comment: "商品名"
#   t.string   "outer_product_id",  limit: 30,                            default: "",              comment: "外部商品ID"
#   t.string   "page_url",          limit: 255,                           default: "",              comment: "商品页链接"
#   t.string   "item_img",          limit: 200,                           default: "",              comment: "商品图片路径"
#   t.text     "properties",        limit: 65535,                                                   comment: "商品属性"
#   t.decimal  "unit_price",                      precision: 8, scale: 2,                           comment: "单价"
#   t.integer  "number",            limit: 4,                             default: 1,               comment: "刷单数量"
#   t.decimal  "search_price",                    precision: 8, scale: 2,                           comment: "搜索价格"
#   t.text     "search_attributes", limit: 65535,                                                   comment: "搜索属性"
#   t.decimal  "gte_price",                       precision: 8, scale: 2,                           comment: "搜索价格区间（最小）"
#   t.decimal  "lte_price",                       precision: 8, scale: 2,                           comment: "搜索价格区间（最大）"
#   t.string   "area_name",         limit: 255,                                                     comment: "搜索地区"
#   t.datetime "created_at",                                                           null: false
#   t.datetime "updated_at",                                                           null: false
# end
# add_index "products", ["issue_id"], name: "idx_by_issue_id", using: :btree
class Product < ActiveRecord::Base
  belongs_to  :issue
end