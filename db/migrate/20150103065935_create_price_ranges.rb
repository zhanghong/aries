class CreatePriceRanges < ActiveRecord::Migration
  def change
    create_table :price_ranges do |t|
      t.integer  :account_type_id,   default: 0, comment: '平台类型'
      t.string  :task_type,   default: "", limit: 30, comment: '任务类型'
      t.integer  :gte_price,   default: 0, precision: 8, scale: 2, comment: '价格档起始金额'
      t.integer  :lte_price,   default: 0, precision: 8, scale: 2, comment: '价格档结束金额'
      t.decimal  :seller_point,   default: 0, precision: 5, scale: 2, comment: '商家付的爆点值'
      t.decimal  :buyer_point,   default: 0, precision: 5, scale: 2, comment: '买手得到的爆点值'
      t.decimal  :stytem_point,   default: 0, precision: 5, scale: 2, comment: '平台费用'
      t.integer  :updater_id,   default: 0, comment: '编辑管理员'
      t.datetime  :deleted_at, comment: '删除时间'
      t.timestamps null: false
    end

    add_index :price_ranges,  [:account_type_id, :task_type], name: "idx_by_account_type_id_and_task_type"
  end
end
