class CreateIssueServices < ActiveRecord::Migration
  def change
    create_table :issue_services do |t|
      t.integer  :issue_id,   default: 0, comment: '所属发布任务'
      t.string  :service_name,   default: "", limit: 30, comment: '服务名'
      t.decimal  :unit_price,   default: 0, precision: 5, scale: 2, comment: '服务单价'
      t.integer  :number,   default: 1, comment: '购买数量'
      t.decimal  :total_price,   default: 0, precision: 5, scale: 2, comment: '总价'
      t.string  :return_type, comment: '返还类型'
      t.string  :updater_id,   default: 0, comment: '更新用户'
      t.timestamps null: false
    end

    add_index :issue_services,  :issue_id,  name: "idx_by_issue_id"
  end
end
