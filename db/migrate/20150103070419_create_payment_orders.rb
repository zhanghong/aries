class CreatePaymentOrders < ActiveRecord::Migration
  def change
    create_table :payment_orders do |t|
      t.integer  :user_id,   default: 0, comment: '关联用户iD'
      t.string  :related_type,   default: "", limit: 30, comment: '关联任务类型'
      t.integer  :related_id,   default: 0, comment: '关联任务iD'
      t.string  :flow_type,   default: "", limit: 30, comment: '订单类型'
      t.string  :status,   default: "pinding", limit: 20, comment: '状态'
      t.string  :related_status,   default: "", limit: 30, comment: '关联对象状态更新结果'
      t.string  :first_use,   default: "point", comment: '优先使用类型'
      t.decimal  :unit_cash,   default: 0, precision: 12, scale: 2, comment: '购买商品单价（押金）'
      t.decimal  :unit_point,   default: 0, precision: 12, scale: 2, comment: '购买商品单价（爆点）'
      t.integer  :number,   default: 0, comment: '购买数量'
      t.decimal  :total_cash,   default: 0, precision: 12, scale: 2, comment: '应付押金总数'
      t.decimal  :total_point,   default: 0, precision: 12, scale: 2, comment: '应付爆点总数'
      t.decimal  :discount_cash,   default: 0, precision: 12, scale: 2, comment: '优惠押金'
      t.decimal  :discount_point,   default: 0, precision: 12, scale: 3, comment: '优惠爆点'
      t.decimal  :commission_point,   default: 0, precision: 12, scale: 4, comment: '系统服务费爆点'
      t.decimal  :real_cash,   default: 0, precision: 12, scale: 5, comment: '实付押金'
      t.decimal  :real_point,   default: 0, precision: 12, scale: 6, comment: '实付爆点'
      t.decimal  :inner_cash,   default: 0, precision: 12, scale: 2, comment: '使用可用押金支付金额'
      t.decimal  :inner_point,   default: 0, precision: 12, scale: 2, comment: '使用可用爆点支付数量'
      t.decimal  :outer_cash,   default: 0, precision: 12, scale: 2, comment: '使用第三方平台支付金额'
      t.decimal  :outer_point,   default: 0, precision: 12, scale: 2, comment: '使用第三方平台支付爆点数量'
      t.datetime  :pay_expired_at, comment: '支付过期时间'
      t.string  :memo,   default: "", limit: 100, comment: '订单备注'
      t.string  :result_info,   default: "", limit: 100, comment: '支付结果信息'
      t.timestamps null: false
    end

    add_index :payment_orders,  [:user_id, :related_type, :related_id], name: "idx_by_user_id_and_related_type_and_related_id"
  end
end
