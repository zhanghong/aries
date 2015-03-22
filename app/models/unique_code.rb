# create_table "unique_codes", force: :cascade do |t|
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end
class UniqueCode < ActiveRecord::Base

  # 生成唯一码
  def self.generate
    item = create()
    return item.id.to_s(16).upcase.rjust(6, "0")
  end
end