class CreateLogisticOrders < ActiveRecord::Migration
  def change
    create_table :logistic_orders do |t|
      t.string  :serial_no,   default: "", limit: 20, comment: '物流单号'
      t.string  :compay_code,   default: "", limit: 6, comment: '物流公司编号'
      t.datetime  :used_time, comment: '使用时间'
      t.integer  :task_id,   default: 0, comment: '使用任务ID'
      t.string  :batch_no,   default: "", limit: 12, comment: '导出批次号'
      t.integer  :updater_id,   default: 0, comment: '更新用户ID'
      t.timestamps null: false
    end
  end
end
