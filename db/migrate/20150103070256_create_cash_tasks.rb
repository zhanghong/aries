class CreateCashTasks < ActiveRecord::Migration
  def change
    create_table :cash_tasks do |t|
      t.string  :serial_no,   default: "", limit: 30, comment: '任务编号'
      t.integer  :user_id,   default: 0, comment: '提现用户'
      t.string  :type,   default: "", limit: 40, comment: '现金流向'
      t.string  :status,   default: 'pinding', limit: 20, comment: '状态'
      t.decimal  :actived_cash,   default: 0, precision: 12, scale: 2, comment: '充值或调整可用押金'
      t.decimal  :actived_point,   default: 0, precision: 12, scale: 2, comment: '调整可用爆点'
      t.decimal  :commission_cash,   default: 0, precision: 10, scale: 2, comment: '任务押金手续费'
      t.decimal  :real_cash,   default: 0, precision: 12, scale: 2, comment: '任务实际到账押金'
      t.decimal  :commission_point,   default: 0, precision: 10, scale: 2, comment: '任务爆点手续费'
      t.decimal  :real_point,   default: 0, precision: 12, scale: 2, comment: '任务实际到账爆点'
      t.string  :memo,   default: "", comment: '备注'
      t.integer  :updater_id,   default: 0, comment: '更新用户'
      t.timestamps null: false
    end

    add_index :cash_tasks,  :serial_no, name: "idx_by_serial_no"
    add_index :cash_tasks,  [:type, :user_id, :serial_no],  name: "idx_by_type_user_id_and_serial_no"
  end
end
