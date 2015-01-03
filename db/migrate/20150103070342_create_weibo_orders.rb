class CreateWeiboOrders < ActiveRecord::Migration
  def change
    create_table :weibo_orders do |t|
      t.integer  :user_id,   default: 0, comment: '所属用户ID'
      t.string  :status,   default: "pinding", limit: 20, comment: '订单状态'
      t.string  :paied_type,   default: "", limit: 50, comment: '支付对象类型'
      t.integer  :paied_id,   default: 0, comment: '支付对象ID'
      t.string  :event_name,   default: "", limit: 30, comment: '支付事件名'
      t.decimal  :amount,   precision: 12, scale: 2, comment: '支付金额'
      t.datetime  :expired_at, comment: '支付过期时间'
      t.timestamps null: false
    end
    add_index :weibo_orders,  [:user_id, :paied_type, :paied_id], name: "idx_by_user_id_and_paied_type_and_paied_id"
  end
end
