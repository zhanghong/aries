class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.integer  :taobao_id,   default: 0, comment: '对应淘宝ID'
      t.string  :name,   default: "", limit: 30, comment: '省/市/区名称'
      t.integer  :parent_id,   default: 0, comment: '父级名称'
      t.string  :pinyin,   default: "", limit: 10, comment: '拼音简写'
      t.string  :zipcode,   default: "", limit: 8, comment: '邮编'
      t.integer  :updater_id,   default: 0, comment: '更新管理员ID'
      t.datetime  :deleted_at, comment: '删除时间'
      t.timestamps null: false
    end

    add_index :areas, [:parent_id, :name],  name: "idx_by_parent_id_and_name" 
  end
end
