class CreateIssueLogs < ActiveRecord::Migration
  def change
    create_table :issue_logs do |t|
      t.integer  :issue_id,   default: 0, comment: '所属发布任务ID'
      t.string  :status,   default: "pinding", limit: 20, comment: '状态'
      t.text  :content, comment: '更新内容'
      t.string  :memo,   default: "", comment: '备注'
      t.integer  :updater_id,   default: 0, comment: '更新用户ID'
      t.timestamps null: false
    end
    add_index :issue_logs,  :issue_id,  name: "idx_by_issue_id"
  end
end
