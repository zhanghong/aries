class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.integer  :user_id,   default: 0, comment: '所属用户ID'
      t.string  :promotion_type,   default: "", limit: 30, comment: '推广类型'
      t.integer  :related_user_id,   default: 0, comment: '触发推广事件用户ID'
      t.decimal  :actived_point,   default: 0, precision: 8, scale: 2, comment: '所获得的可用爆点'
      t.string  :memo,   default: "", limit: 100, comment: '备注信息'
      t.timestamps null: false
    end
    add_index :promotions,  [:user_id,  :promotion_type], name: "idx_by_user_id_and_promotion_type"
  end
end
