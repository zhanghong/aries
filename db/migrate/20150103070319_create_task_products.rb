class CreateTaskProducts < ActiveRecord::Migration
  def change
    create_table :task_products do |t|
      t.integer  :task_id,   default: 0, comment: '关联task'
      t.integer  :buyer_id,   default: 0, comment: '关联买手'
      t.integer  :buyer_account_id,   default: 0, comment: '关联买手购买账号'
      t.integer  :seller_id,   default: 0, comment: '关联商家'
      t.integer  :seller_account_id,   default: 0, comment: '关联商家店铺账号'
      t.string  :outer_product_id,   default: "", limit: 30, comment: '外部商品ID'
      t.date  :expire_on, comment: '过期日期'
      t.timestamps null: false
    end
    add_index :task_products, [:buyer_id, :buyer_account_id, :seller_id, :seller_account_id], name: "idx_by_byid_and_buyer_account_id_and_slid_seller_account_id"
  end
end
