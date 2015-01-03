class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer  :user_id,   default: 0, comment: '关联用户'
      t.integer  :account_type_id,   default: 0, comment: '关联账号类型'
      t.string  :type,   default: "", limit: 30, comment: '账号类型'
      t.integer  :platform_id,   default: 0, comment: '平台类型ID'
      t.string  :name,   default: "", limit: 50, comment: '账号名'
      t.string  :sub_name,   default: "", limit: 50, comment: '账号辅助名，如银行卡的开户支行名，淘宝店铺掌柜ID'
      t.string  :receive_name,   default: "", limit: 30, comment: '收货人姓名'
      t.string  :receive_phone,   default: "", limit: 15, comment: '收货人手机'
      t.string  :status,   default: "pinding", limit: 20, comment: '状态'
      t.integer  :area_id,   default: 0, comment: '收货地区'
      t.string  :area_name,   default: "", limit: 100, comment: '所在地区名'
      t.string  :home_page,   default: "", comment: '首页URL'
      t.string  :address,   default: "", comment: '收货地址'
      t.string  :zipcode,   default: "", limit: 8, comment: '邮编'
      t.string  :picture,   default: "", comment: '截图URL'
      t.string  :memo,   default: "", comment: '备注'
      t.string  :failed_reason,   default: "", comment: '审核失败原因'
      t.integer  :updater_id,   default: 0, comment: '更新用户ID'
      t.datetime  :deleted_at, comment: '删除时间'
      t.timestamps null: false
    end

    add_index :accounts,  [:type, :user_id,  :platform_id], name: "idx_by_type_user_id_and_platform_id"
    add_index :accounts,  [:type, :user_id,  :account_type_id], name: "idx_by_type_user_id_and_account_type"
  end
end
