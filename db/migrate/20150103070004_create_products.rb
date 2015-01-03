class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer  :issue_id,   default: 0, comment: '所属任务'
      t.string  :name,   default: "", limit: 100, comment: '商品名'
      t.string  :outer_product_id,   default: "", limit: 30, comment: '外部商品ID'
      t.string  :page_url,   default: "", comment: '商品页链接'
      t.string  :item_img,   default: "", limit: 200, comment: '商品图片路径'
      t.text  :properties, comment: '商品属性'
      t.decimal  :unit_price,   precision: 8, scale: 2, comment: '单价'
      t.integer  :number,   default: 1, comment: '刷单数量'
      t.decimal  :search_price,   precision: 8, scale: 2, comment: '搜索价格'
      t.text  :search_attributes, comment: '搜索属性'
      t.decimal  :gte_price,   precision: 8, scale: 2, comment: '搜索价格区间（最小）'
      t.decimal  :lte_price,   precision: 8, scale: 2, comment: '搜索价格区间（最大）'
      t.string  :area_name, comment: '搜索地区'
      t.timestamps null: false
    end

    add_index :products,  :issue_id,  name: "idx_by_issue_id"
  end
end
