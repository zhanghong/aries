class CreateAccountTypes < ActiveRecord::Migration
  def change
    create_table :account_types do |t|
      t.string  :type,   default: "", limit: 20, comment: '种类'
      t.integer  :platform_id,   default: 0, comment: '平台类型ID'
      t.string  :name,   default: "", limit: 20, comment: '类型名'
      t.string  :image,   default: "", comment: '图片'
      t.string  :icon_url,   default: "", limit: 150, comment: 'icon图标URL'
      t.integer  :limit_count,   default: 1, comment: '每个用户可绑定的数量'
      t.string  :status,   default: "actived", limit: 20, comment: '状态'
      t.integer  :updater_id,   default: 0, comment: '编辑管理员'
      t.datetime  :deleted_at, comment: '删除时间'
      t.timestamps null: false
    end

    add_index :account_types, [:platform_id, :name],  name: "idx_by_platform_id_and_name"
  end
end
