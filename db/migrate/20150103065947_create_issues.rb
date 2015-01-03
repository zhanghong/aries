class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.integer  :user_id,   default: 0, comment: '关联商家用户'
      t.integer  :platform_id,   default: 0, comment: '平台类型ID'
      t.integer  :account_type_id,   default: 0, comment: '账号类型ID'
      t.integer  :account_id,   default: 0, comment: '所属账号'
      t.integer  :parent_id,   default: 0, comment: '父级任务ID'
      t.string  :serial_no,   default: "", limit: 30, comment: '项目编号'
      t.string  :issue_type,   default: "", limit: 30, comment: '任务类型'
      t.string  :task_type,   default: "", comment: '任务类型'
      t.string  :post_type,   default: "pay", comment: '邮费类型'
      t.integer  :total_number,   default: 1, comment: '总刷单数量'
      t.integer  :unit_product_count,   default: 0, comment: '每单购买的商品件数'
      t.decimal  :unit_price,   default: 0, precision: 10, scale: 2, comment: '每单的单价'
      t.decimal  :unit_insurance,   default: 0, precision: 10, scale: 2, comment: '每单扣除的保险金'
      t.decimal  :unit_postage,   default: 0, precision: 5, scale: 2, comment: '每单扣除的邮费'
      t.integer  :pc_number,   default: 0, comment: '电脑刷单量'
      t.integer  :pc_did_number,   default: 0, comment: '电脑已完成或正在刷单量'
      t.integer  :mobile_number,   default: 0, comment: '手机/pad刷单量'
      t.integer  :mobile_did_number,   default: 0, comment: '手机/pad已完成刷单量'
      t.text  :comment_list, comment: '卖家给的备注模板'
      t.decimal  :seller_base_point,   default: 0, precision: 5, scale: 2, comment: '每单商家支付的基本爆点费用'
      t.decimal  :seller_add_point,   default: 0, precision: 5, scale: 2, comment: '每单商家支付的悬赏爆点费用'
      t.decimal  :seller_all_point,   default: 0, precision: 5, scale: 2, comment: '每单商家支付的所有爆点'
      t.decimal  :buyer_base_point,   default: 0, precision: 5, scale: 2, comment: '每单买手得到的基本爆点'
      t.decimal  :buyer_add_point,   default: 0, precision: 5, scale: 2, comment: '每单买手得到的悬赏爆点'
      t.decimal  :buyer_point,   default: 0, precision: 5, scale: 2, comment: '每单买手得到的总爆点'
      t.decimal  :locked_deposit,   default: 0, precision: 10, scale: 2, comment: '冻结的押金'
      t.decimal  :locked_insurance,   default: 0, precision: 10, scale: 2, comment: '冻结的保险金'
      t.decimal  :locked_postage,   default: 0, precision: 10, scale: 2, comment: '冻结的邮费'
      t.decimal  :locked_point,   default: 0, precision: 10, scale: 2, comment: '冻结爆点'
      t.decimal  :commission_point,   default: 0, precision: 10, scale: 2, comment: '发布任务的平台佣金爆点'
      t.string  :status,   default: "pinding", limit: 20, comment: '任务状态'
      t.string  :point_status,   default: "locked", limit: 20, comment: '爆点返还状态'
      t.string  :failed_reason,   default: "", limit: 100, comment: '审核失败原因'
      t.boolean  :is_priority,   default: false, comment: '是否优先排列'
      t.integer  :template_id,   default: 0, comment: '模板ID'
      t.integer  :updater_id,   default: 0, comment: '更新用户ID'
      t.timestamps null: false
    end

    add_index :issues,  [:user_id,  :account_id], name: "idx_by_user_id_and_account_id"
    add_index :issues,  [:platform_id, :account_type_id, :parent_id], name: "idx_by_platform_account_type_id_and_parent_id"
  end
end
