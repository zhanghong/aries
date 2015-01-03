class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.integer  :user_id,   default: 0, comment: '所属用户ID'
      t.string  :status,   default: "", limit: 30, comment: '下载文件状态'
      t.string  :target_type,   default: "", limit: 30, comment: '下载任务类型'
      t.text  :conditions, comment: '下载条件'
      t.integer  :record_count,   default: 0, comment: '下载数据条数'
      t.string  :file_path,   default: "", limit: 100, comment: '下载文件路径'
      t.integer  :file_size,   default: 0, comment: '文件大小'
      t.integer  :down_count,   default: 0, comment: '下载次数'
      t.timestamps null: false
    end
    add_index :downloads, :user_id, name: "idx_by_user_id"
    add_index :downloads, [:target_type,  :user_id], name: "idx_by_target_type_and_user_id"
  end
end
