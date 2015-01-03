class CreateDownloadLogs < ActiveRecord::Migration
  def change
    create_table :download_logs do |t|
      t.integer  :download_id,   default: 0, comment: '所属下载任务ID'
      t.integer  :user_id,   default: 0, comment: '所属用户ID'
      t.timestamps null: false
    end
    add_index :download_logs,  :user_id,  name: "idx_by_user_id"
    add_index :download_logs, [:download_id,  :user_id],  name: "idx_by_download_id_and_user_id"
  end
end
