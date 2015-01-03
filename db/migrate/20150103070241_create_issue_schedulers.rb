class CreateIssueSchedulers < ActiveRecord::Migration
  def change
    create_table :issue_schedulers do |t|
      t.integer  :issue_id,   default: 0, comment: '关联商家发布任务'
      t.string  :status,   default: 'pinding', limit: 20, comment: '状态'
      t.integer  :interval_minutes,   default: 0, comment: '间隔分钟'
      t.integer  :pc_number,   default: 0, comment: 'PC端每次发布订单数量'
      t.integer  :mobile_number,   default: 0, comment: '移动端每次发布订单数量'
      t.integer  :updater_id,   default: 0, comment: '更新用户ID'
      t.timestamps null: false
    end

    add_index :issue_schedulers,  :issue_id,  name: "idx_by_issue_id"
  end
end
