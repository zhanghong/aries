# create_table "download_logs", force: :cascade do |t|
#   t.integer  "download_id", limit: 4, default: 0,              comment: "所属下载任务ID"
#   t.integer  "user_id",     limit: 4, default: 0,              comment: "所属用户ID"
#   t.datetime "created_at",                        null: false
#   t.datetime "updated_at",                        null: false
# end
# add_index "download_logs", ["download_id", "user_id"], name: "idx_by_download_id_and_user_id", using: :btree
# add_index "download_logs", ["user_id"], name: "idx_by_user_id", using: :btree
class DownloadLog < ActiveRecord::Base
  belongs_to  :download
  belongs_to  :user
end