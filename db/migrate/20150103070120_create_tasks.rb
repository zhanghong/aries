class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer  :issue_id,   default: 0, comment: '所属商家发布任务'
      t.integer  :parent_issue_id,   default: 0, comment: '所属商家发布任务组'
      t.integer  :platform_id,   default: 0, comment: '平台类型ID'
      t.integer  :seller_id,   default: 0, comment: '商家ID'
      t.integer  :buyer_id,   default: 0, comment: '买手id'
      t.integer  :seller_account_id,   default: 0, comment: '商家发布任务店铺ID'
      t.integer  :buyer_account_id,   default: 0, comment: '买手使用的账号ID'
      t.string  :serial_no,   default: "", limit: 30, comment: '任务编号'
      t.string  :outer_serial_no,   default: "", limit: 30, comment: '外部平台的订单ID'
      t.string  :terminal_type,   default: "", comment: '终端类型'
      t.string  :task_type,   default: "", limit: 30, comment: '任务类型'
      t.string  :status,   default: "pinding", limit: 30, comment: '当前状态'
      t.datetime  :pay_expired_at, comment: '付款过期时间'
      t.datetime  :refund_expired_at, comment: '商家退款最晚时间'
      t.integer  :refund_account_id,   default: 0, comment: '退款账号ID'
      t.string  :refund_account_name,   default: "", limit: 50, comment: '退款账号名'
      t.string  :refund_account_receive_name,   default: "", limit: 50, comment: '退款账号的用户名'
      t.string  :sub_status,   default: "pinding", limit: 30, comment: '子状态'
      t.decimal  :locked_point,   default: 0, precision: 5, scale: 2, comment: '买手接任务时扣的爆点'
      t.decimal  :seller_base_point,   default: 0, precision: 5, scale: 2, comment: '每单商家支付的基本爆点费用'
      t.decimal  :seller_add_point,   default: 0, precision: 5, scale: 2, comment: '每单商家支付的悬赏爆点费用'
      t.decimal  :seller_all_point,   default: 0, precision: 5, scale: 2, comment: '每单商家支付的所有爆点'
      t.decimal  :buyer_base_point,   default: 0, precision: 5, scale: 2, comment: '每单买手得到的基本爆点'
      t.decimal  :buyer_add_point,   default: 0, precision: 5, scale: 2, comment: '每单买手得到的悬赏爆点'
      t.decimal  :buyer_all_point,   default: 0, precision: 5, scale: 2, comment: '每单买手得到的总爆点'
      t.string  :point_status,   default: "locked", limit: 20, comment: '爆点返还状态'
      t.string  :payment_type,   default: "", limit: 30, comment: '付款类型'
      t.decimal  :payment_price,   default: 0, precision: 10, scale: 2, comment: '买手实付金额'
      t.integer  :receive_area_id,   default: 0, comment: '收货人所在地区'
      t.string  :receive_area_name,   default: "", limit: 100, comment: '收货人所在地区名'
      t.string  :receive_address,   default: "", comment: '收货人详细地址'
      t.string  :receive_name,   default: "", limit: 30, comment: '收货人名'
      t.string  :receive_phone,   default: "", limit: 30, comment: '收货人手机'
      t.string  :logistic_serial_no,   default: "", limit: 20, comment: '物流单号'
      t.string  :logistic_compay_code,   default: "", limit: 6, comment: '物流公司编号'
      t.integer  :buyer_integral,   default: 0, comment: '买手做完任务获得的经验值（积分）'
      t.integer  :updater_id,   default: 0, comment: '更新用户ID'
      t.timestamps null: false
    end

    add_index :tasks, [:parent_issue_id, :issue_id],  name: "idx_by_parent_issue_id_and_issue_id"
    add_index :tasks, [:seller_id,  :seller_account_id, :serial_no],  name: "idx_by_seller_id_seller_account_id_and_serial_no"
    add_index :tasks, [:buyer_id, :buyer_account_id, :serial_no], name: "idx_by_buyer_id_buyer_account_id_and_serial_no"
    add_index :tasks, :serial_no, name: "idx_by_serial_no"
  end
end
