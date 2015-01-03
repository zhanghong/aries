class CreatePlatforms < ActiveRecord::Migration
  def change
    create_table :platforms do |t|
      t.string  :name,   default: "", limit: 30, comment: '平台名'
      t.string  :image,   default: "", comment: '图片'
      t.integer  :updater_id,   default: 0, comment: '更新用户'
      t.datetime  :deleted_at, comment: '删除时间'
      t.timestamps null: false
    end
  end
end
