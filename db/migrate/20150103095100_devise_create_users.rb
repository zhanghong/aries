class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :name,               default: "", limit: 50
      t.string :email,              null: false, default: "", limit: 100
      t.string  :phone,   limit: 30, default: "", comment: '手机号码'
      t.string  :qq,   limit: 30, default: "", comment: 'QQ号码'
      t.string  :wangwang,   limit: 30, default: "", comment: '旺旺号码'
      t.string  :from_type,   limit: 10, default: "", comment: '注册来源'
      t.string  :type,   limit: 10, default: "", comment: '用户类型'
      t.string  :avatar,   default: "", comment: '用户头像'
      t.string  :gender,   default: "", comment: '用户性别'
      t.date  :born_on, comment: '出生日期'
      t.integer  :area_id,   default: 0, comment: '所在地区ID'
      t.string  :area_name,   default: "", limit: 100, comment: '所在地区名'
      t.string :encrypted_password, null: false, default: ""
      t.string  :encrypted_pay_password,   default: "", comment: '支付密码'
      t.integer  :alipay_account_id,   default: 0, comment: '支付宝账号ID'
      t.integer  :tenpay_account_id,   default: 0, comment: '财富通账号ID'
      t.integer  :bank_account_id,   default: 0, comment: '银行卡账号ID'
      t.string  :invitation_code,   default: "", limit: 10, comment: '邀请码'
      t.string  :invitater_name,   default: "", limit: 30, comment: '邀请用户名'
      t.integer  :invitator_id,   default: 0, comment: '邀请用户ID'
      t.integer  :vip_months,   default: 0, comment: '用户累计开通VIP多少个月'
      t.date  :expired_on, comment: '账户过期时间'
      t.datetime  :freezed_at, comment: '账户冻结时间'
      t.string  :freezed_reason,   default: "", comment: '账户冻结原因'
      t.string  :freezed_memo,   default: "", comment: '账户冻结备注'
      t.integer  :freezer_id, comment: '冻结操作管理员'

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      t.string  :last_sign_in_area,   default: "", limit: 50, comment: '上次登录地区'
      t.string  :current_sign_in_area,   default: "", limit: 50, comment: '本次登录地区'

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at
      t.timestamps
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true
  end
end
