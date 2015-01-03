class CreateTaskLogs < ActiveRecord::Migration
  def change
    create_table :task_logs do |t|
      t.integer  :task_id, comment: '所属买手任务id'
      t.string  :status,   default: "", limit: 30, comment: '状态'
      t.string  :sub_status,   default: "", limit: 30, comment: '子状态'
      t.text  :contents, comment: '更新内容'
      t.string  :memo,   default: "", comment: '备注'
      t.integer  :used_seconds,   default: 0, comment: '使用时间（秒）'
      t.integer  :updater_id,   default: 0, comment: '更新用户ID'
      t.timestamps null: false
    end
    add_index :task_logs, :task_id, name: "idx_by_task_id"
  end
end
