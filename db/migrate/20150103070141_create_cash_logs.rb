class CreateCashLogs < ActiveRecord::Migration
  def change
    create_table :cash_logs do |t|
      t.string  :serial_no,   default: "", limit: 30, comment: '任务编号'
      t.string  :flow_type,   default: "", limit: 40, comment: '流水类型'
      t.string  :status,   default: "", limit: 20, comment: '状态'
      t.integer  :source_id,   default: 0, comment: '资金来源用户ID'
      t.integer  :target_id,   default: 0, comment: '资金去向用户ID'
      t.decimal  :actived_cash,   precision: 10, scale: 2, comment: '可用押金/本金流水'
      t.decimal  :locked_cash,   precision: 12, scale: 2, comment: '冻结押金/本金流水'
      t.decimal  :actived_point,   precision: 10, scale: 2, comment: '可用爆点流水'
      t.decimal  :locked_point,   precision: 12, scale: 2, comment: '冻结爆点流水'
      t.decimal  :current_actived_cash,   default: 0, precision: 12, scale: 2, comment: '流水结算后的可用押金/本金'
      t.decimal  :current_locked_cash,   default: 0, precision: 12, scale: 2, comment: '流水结算后的冻结押金/本金'
      t.decimal  :current_actived_point,   default: 0, precision: 12, scale: 2, comment: '流水结算后的可用爆点'
      t.decimal  :current_locked_point,   default: 0, precision: 12, scale: 2, comment: '流水结算后的冻结爆点'
      t.string  :related_type,   default: "", limit: 30, comment: '关联对象类型'
      t.integer  :related_id,   default: 0, comment: '关联对象ID'
      t.string  :memo,   default: "", comment: '备注'
      t.integer  :operater_id,   default: 0, comment: '操作用户ID'
      t.timestamps null: false
    end
    add_index :cash_logs, [:target_id,  :flow_type],  name: "idx_by_target_id_and_flow_type"
  end
end
