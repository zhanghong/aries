class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.integer  :used_monthly_cash_count,   default: 0, comment: '每月已用提现次数'
      t.integer  :used_monthly_point_count,   default: 0, comment: '每月已用爆点转现金次数'
      t.integer  :succed_task_count,   default: 0, comment: '成功任务数量'
      t.integer  :failed_task_count,   default: 0, comment: '失败任务数量'
      t.decimal  :actived_cash,   default: 0, precision: 12, scale: 2, comment: '可用押金(本金）'
      t.decimal  :locked_cash,   default: 0, precision: 12, scale: 2, comment: '锁定/垫付押金(本金）'
      t.decimal  :total_cash,   default: 0, precision: 12, scale: 2, comment: '累计押金(本金）'
      t.decimal  :actived_point,   default: 0, precision: 12, scale: 2, comment: '可用爆点'
      t.decimal  :locked_point,   default: 0, precision: 12, scale: 2, comment: '锁定爆点'
      t.decimal  :total_point,   default: 0, precision: 12, scale: 2, comment: '累计爆点'
      t.decimal  :earn_point,   default: 0, precision: 12, scale: 2, comment: '赚取爆点'
      t.integer  :total_integral,   default: 0, comment: '总共获得的积分'
      t.integer  :actived_integral,   default: 0, comment: '当前有效积分'
      t.integer  :freezer_id,   default: 0, comment: '冻结管理员ID'
      t.datetime  :freezed_at, comment: '冻结时间'
      t.timestamps null: false
    end
  end
end
