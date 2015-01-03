class CreateAccountLogs < ActiveRecord::Migration
  def change
    create_table :account_logs do |t|
      t.integer  :account_id,   default: 0, comment: '关联账号ID'
      t.string  :status,   default: "", limit: 20, comment: '状态'
      t.string  :memo,   default: "", comment: '备注'
      t.integer  :updater_id,   default: 0, comment: '更新用户ID'
      t.timestamps null: false
    end

    add_index :account_logs,  :account_id,  name: "idx_by_account_id"
  end
end
