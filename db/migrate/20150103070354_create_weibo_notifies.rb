class CreateWeiboNotifies < ActiveRecord::Migration
  def change
    create_table :weibo_notifies do |t|
      t.integer  :weibo_order_id,   default: 0, comment: '所属微博订单'
      t.string  :merchant_account_id,   default: "", limit: 40, comment: '人民币账号'
      t.string  :version,   default: 0, limit: 10, comment: '网关版本'
      t.string  :language,   default: "", limit: 2, comment: '网页显示语言'
      t.integer  :sign_type,   default: 0, comment: '签名类型'
      t.string  :pay_type,   default: "", limit: 2, comment: '支付方式'
      t.string  :bank_id,   default: "", limit: 8, comment: '银行代码'
      t.datetime  :order_time, comment: '订单提交时间'
      t.decimal  :order_amount,   precision: 12, scale: 2, comment: '订单金额'
      t.string  :deal_id,   default: "", limit: 30, comment: '新浪支付交易号'
      t.string  :bank_deal_id,   default: "", limit: 30, comment: '银行交易号'
      t.datetime  :deal_time, comment: '在新浪支付成功的时间'
      t.decimal  :pay_amount,   precision: 12, scale: 2, comment: '订单实付金额'
      t.decimal  :fee,   precision: 12, scale: 2, comment: '费用'
      t.string  :ext1,   default: "", limit: 128, comment: '扩展字段1'
      t.string  :ext2,   default: "", limit: 128, comment: '扩展字段2'
      t.integer  :pay_result,   default: 0, comment: '处理结果'
      t.string  :pay_ip,   default: "", limit: 15, comment: '在网银的支付IP'
      t.string  :err_code,   default: "", limit: 10, comment: '错误代码'
      t.text  :sign_msg, comment: '签名字符串'
      t.timestamps null: false
    end

    add_index :weibo_notifies,  [:weibo_order_id],  name: "idx_by_weibo_order_id"
  end
end
