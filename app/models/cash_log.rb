# create_table "cash_logs", force: :cascade do |t|
#   t.string   "serial_no",             limit: 30,                           default: "",               comment: "任务编号"
#   t.string   "flow_type",             limit: 40,                           default: "",               comment: "流水类型"
#   t.string   "status",                limit: 20,                           default: "",               comment: "状态"
#   t.integer  "source_id",             limit: 4,                            default: 0,                comment: "资金来源用户ID"
#   t.integer  "target_id",             limit: 4,                            default: 0,                comment: "资金去向用户ID"
#   t.decimal  "actived_cash",                      precision: 10, scale: 2,                            comment: "可用押金/本金流水"
#   t.decimal  "locked_cash",                       precision: 12, scale: 2,                            comment: "冻结押金/本金流水"
#   t.decimal  "actived_point",                     precision: 10, scale: 2,                            comment: "可用爆点流水"
#   t.decimal  "locked_point",                      precision: 12, scale: 2,                            comment: "冻结爆点流水"
#   t.decimal  "current_actived_cash",              precision: 12, scale: 2, default: 0.0,              comment: "流水结算后的可用押金/本金"
#   t.decimal  "current_locked_cash",               precision: 12, scale: 2, default: 0.0,              comment: "流水结算后的冻结押金/本金"
#   t.decimal  "current_actived_point",             precision: 12, scale: 2, default: 0.0,              comment: "流水结算后的可用爆点"
#   t.decimal  "current_locked_point",              precision: 12, scale: 2, default: 0.0,              comment: "流水结算后的冻结爆点"
#   t.string   "related_type",          limit: 30,                           default: "",               comment: "关联对象类型"
#   t.integer  "related_id",            limit: 4,                            default: 0,                comment: "关联对象ID"
#   t.string   "memo",                  limit: 255,                          default: "",               comment: "备注"
#   t.integer  "operater_id",           limit: 4,                            default: 0,                comment: "操作用户ID"
#   t.datetime "created_at",                                                               null: false
#   t.datetime "updated_at",                                                               null: false
# end
# add_index "cash_logs", ["target_id", "flow_type"], name: "idx_by_target_id_and_flow_type", using: :btree
class CashLog < ActiveRecord::Base
  belongs_to  :source_user, class_name: "User", foreign_key: "source_id"
  belongs_to  :target_user, class_name: "User", foreign_key: "target_id"
  belongs_to  :operater_user, class_name: "User", foreign_key: "operater_id"

  validates :serial_no, presence: true, uniqueness: true, length: {maximum: 30}
  validates :flow_type, presence: true, length: {maximum: 30}
  validates :status, presence: true, length: {maximum: 20}
  validates :source_id, presence: true
  validates :target_id, presence: true
  validates :actived_cash,  presence: true
  validates :actived_point, presence: true
  validates :current_actived_cash,  presence: true
  validates :current_actived_point, presence: true
  validates :current_locked_cash, presence: true
  validates :current_locked_point,  presence: true

  before_save :set_operater_id
  before_create :generate_serial_no

  FLOW_TYPES = [
    ["会员开通奖励", "vip_open_reward"],
    ["会员续费", "vip_renewal"],
    ["会员续费奖励", "vip_renewal_reward"],
    ["会员推广奖励", "vip_promotion_reward"],
    ["推广用户完成任务奖励", "task_promotion_reward"],
    ["爆点兑换", "point_exchange"],
    ["爆点充值", "point_recharge"],
    ["本金/押金提现(待开始）", "cash_draw_pinded"],
    ["本金/押金提现（成功）", "cash_draw_succeed"],
    ["本金/押金提现（失败）", "cash_draw_failed"],
    ["押金充值", "cash_recharge_succeed"],
    ["押金（爆点）调整", "cash_adjust_succeed"],
    ["（商家）发布任务", "issue_publish"],
    ["（商家）取消任务", "issue_cancel"],
    ["任务审核失败", "issue_audite_fail"],
    ["（买手）接任务", "task_start"],
    ["（买手）放弃任务", "task_cancel"],
    ["新手任务奖励", "newer_task_reward"],
    ["（买手）完成任务得到冻结的爆点", "task_finish_buyer_freeze"],
    ["（买手）完成任务得到爆点和垫付金额", "task_finish_buyer_receive"],
    ["（买手）完成任务得到爆点和垫付金额", "task_finish_seller_payment"],
    ["扣除任务保证金", "task_deduct_insurance"],
    ["（商家）发布任务佣金", "issue_publish_commission"],
    ["完成任务佣金", "task_finished_commission"],
    ["爆点兑换佣金", "point_excharge_commission"],
    ["取消任务佣金", "task_cancel_commission"],
    ["用户提现佣金", "cash_draw_commission"],
    ["押金解冻", "cash_freeze"]
  ]

  # 当用户开通会员多少个月可享受更低爆点兑换佣金比例
  MIN_VIP_MONTHS = 12;
  # 新手任务奖励爆点
  POINT_NEWER_TASK = 6;
  # 押金充值最低金额
  MIN_CASH_Recharge = 100;
  # 开通会员奖励爆点
  POINT_VIP_OPEN = 6;
  # 会员续费奖励爆点
  POINT_VIP_RENEWS = 2;
  # 每月本金（押金）可提现次数
  PER_MONTH_CASH_COUNT = 3;
  # 每月爆点可兑换次数
  PER_MONTH_POINT_COUNT = 5;
  # 被邀请买手做完任务后邀请者获得的爆点比例
  PMT_FINISH_TASH = 0.05;

  def self.find_mine(params)
    target_user_joins = "LEFT JOIN users target_users ON cash_log.target_id=target_users.id"
    conditions = search_conditions(params)
    sort_str = search_sorts(params[:order_type])

    self.joins(target_user_joins).where(conditions).order(sort_str)
  end

  # 会员续费-计算系统各项盈利
  # ======== 参数 ===========
  # payment_order_id(Integer) : 交易订单ID
  # ======== 返回值 ===========
  # return Hash
  def self.calculate_system_profit(options = {})
    conds = [["target_id = ? AND status = ?"], User::SYSTEM_ID, "successed"]
    if options[:start_on]
      gte_time = Time.parse(options[:start_on]) rescue nil
      if gte_time
        conds[0] << "created_at >= ?"
        conds << gte_time
      end
    end

    if options[:end_on]
      lte_time = Time.parse(options[:end_on]) rescue nil
      if lte_time
        conds[0] << "created_at <= ?"
        conds << lte_time.end_of_day
      end
    end

    conds[0] = conds[0].join(" AND ")
    select_fields = <<-FILEDS
      id, flow_type,
      SUM(actived_cash) AS actived_cash,
      SUM(actived_point) AS actived_point
    FILEDS

    self.where(conds).group("flow_type").all
  end

  # 用户可查看的日志类型
  # ======== 参数 ===========
  # user(User) : 要查看的用户
  # ======== 返回值 ===========
  # return Hash
  def get_view_flow_types(user)
    if user.is_a?("Buyer")
      keys = ["vip_open_reward", "vip_renewal", "vip_renewal_reward",
        "point_exchange", "point_recharge", "cash_draw_pinded",
        "cash_draw_succeed", "cash_draw_failed",
        "task_start", "task_cancel", "newer_task_reward",
        "task_finish_buyer_freeze", "task_finish_buyer_receive",
        "task_finish_seller_payment"]

      FLOW_TYPES.select{|i| keys.include?(i.last)}
    elsif user.is_a?("Seller")
      keys = ["vip_open_reward", "vip_renewal", "vip_renewal_reward",
              "point_recharge", "cash_draw_pinded",
              "cash_draw_succeed", "cash_draw_failed", "cash_recharge_succeed",
              "issue_publish", "issue_cancel"]
      FLOW_TYPES.select{|i| keys.include?(i.last)}
    elsif user.is_a?("Manager")
      FLOW_TYPES
    else
      []
    end
  end

  # 会员续费-线上第三方支付--开始支付前（冻结用户用爆点和本金支付部分)
  # ======== 参数 ===========
  # payment_order_id(Integer) : 交易订单ID
  # ======== 返回值 ===========
  # return Hash
  def self.pind_online_vip_renewal(payment_order_id)
    cash_logs = []

    payment_order = PaymentOrder.where(["id = ? AND flow_type = ? AND state = ? AND (real_cash > 0 OR real_point > 0)", payment_order_id, "VIP", "pinding"])
    return {status: "failed", message: "充值任务不存在"} if payment_order.blank?

    return {status: "successed", message: "操作成功"} if payment_order.inner_cash == 0 && payment_order.inner_point == 0

    user_id = payment_order.user_id
    user_info = UserInfo.where("id" => user_id).first
    if(user_info.blank?)
      return {status: "failed", message: "用户不存在"}
    elsif(payment_order.inner_cash > 0 && user_info.actived_cash < payment_order.inner_cash){
      return {status: "failed", message: "用户可用押金不足"}
    }elsif(payment_order.inner_point > 0 && user_info.actived_point < payment_order.inner_point){
      return {status: "failed", message: "用户可用爆点不足"}
    }

    default_attrs = {
      flow_type: "vip_renewal",
      status: "successed",
      related_type: payment_order.class_name,
      related_id: payment_order.id,
      memo: "会员续费#{payment_order.number}个月"
    }

    user_cash_log = {}
    # 使用可用押金（本金）支付部分
    if(payment_order.inner_cash > 0){
      user_cash_log[:actived_cash] = 0 - payment_order.inner_cash
      user_cash_log[:locked_cash] = payment_order.inner_cash
    }

    if(payment_order.inner_point > 0){
      user_cash_log[:actived_point] = 0 - payment_order.inner_point
      user_cash_log[:locked_point] = payment_order.inner_point
    }

    if user_cash_log.blank?
      return {status: "successed", message: "数据错误"}
    else
      user_cash_log[:source_id] = user_cash_log[:target_id] = user_id
      cash_logs << user_cash_log.merge(default_attrs)

      return save_log_items(cash_logs)
    end
  end

  def self.update_online_vip_revewal_successed(payment_order_id)
    cash_logs = []

    payment_order = PaymentOrder.where(["id = ? AND flow_type = ? AND state = ? AND (real_cash > 0 OR real_point > 0)", payment_order_id, "VIP", "pinded"])
    return {status: "failed", message: "充值任务不存在"} if payment_order.blank?

    return {status: "successed", message: "操作成功"} if payment_order.inner_cash == 0 && payment_order.inner_point == 0

    base_memo = "会员续费#{payment_order.number}个月"
    user_info = UserInfo.where("id" => payment_order.user_id).first
    if(user_info.blank?)
      return {status: "failed", message: "用户不存在"}
    elsif(payment_order.inner_cash > 0 && user_info.locked_cash < payment_order.inner_cash){
      return {status: "failed", message: "用户冻结押金不足"}
    }elsif(payment_order.inner_point > 0 && user_info.locked_point < payment_order.inner_point){
      return {status: "failed", message: "用户冻结爆点不足"}
    }

    default_attrs = {
      flow_type: "vip_renewal",
      status: "successed",
      related_type: payment_order.class_name,
      related_id: payment_order.id,
      memo: base_memo
    }

    user_cash_log = {}
    sys_cash_log = {}
    # 使用可用押金（本金）支付部分
    if(payment_order.inner_cash > 0){
      user_cash_log[:actived_cash] = 0 - payment_order.inner_cash
      user_cash_log[:locked_cash] = payment_order.inner_cash

      sys_cash_log[:actived_cash] = payment_order.inner_cash
    }

    if(payment_order.inner_point > 0){
      user_cash_log[:actived_point] = 0 - payment_order.inner_point
      user_cash_log[:locked_point] = payment_order.inner_point

      sys_cash_log[:actived_point] = payment_order.inner_point
    }

    if user_cash_log.blank?
      return {status: "successed", message: "数据错误"}
    else
      user_cash_log[:source_id] = SYSTEM_ID
      user_cash_log[:target_id] = user_id
      cash_logs << user_cash_log.merge(default_attrs)

      sys_cash_log[:source_id] = user_id
      sys_cash_log[:target_id] = SYSTEM_ID
      cash_logs << sys_cash_log.merge(default_attrs)

      return save_log_items(cash_logs)
    end
  end

  def flow_type_name
    item = FLOW_TYPES.find{|i| i.last == self.flow_type}
    if item.blank?
      self.flow_type
    else
      item.first
    end
  end
private
  # 生成自定义查询的查询条件
  # ======== 参数 ===========
  # params(Hash) : 查询参数
  # ======== 返回值 ===========
  # return Array
  def self.search_conditions(params)
    conds = [[]]

    if params.is_a?(Hash)
      params.each do |key, val|
        val = val.to_s.strip if val.is_a?(String)
        next if val.blank?
        case key.to_s
        when "order_type", "field_value"
          next
        when "target_user_type"
          conds[0] << "target_users.type = ?"
          conds << val
        when "start_on"
          conds[0] << "cash_logs.created_at >= ?"
          conds << Time.parse(val)
        when "end_on"
          conds[0] << "cash_logs.created_at <= ?"
          conds << Time.parse(val).end_of_day
        when "ids"
          conds[0] << "cash_logs.id IN (?)"
          conds << val
        when "field_name"
          field_value = params[:field_value].to_s.strip
          next if field_value.blank?
          case val
          when "target_user_name"
            conds[0] << "target_user.name LIKE ?"
            conds << "%#{field_value}%"
          when "serial_no", "state"
            conds[0] << "cash_logs.#{val} = ?"
            conds << field_value
          end
        when "id", "serial_no", "target_id"
          conds[0] << "cash_logs.#{key} = ?"
          conds << val
        end
      end
    end

    if conds.blank?
      return []
    else
      conds[0] = conds[0].join(" AND ")
      return conds
    end
  end

  # 生成自定义查询的排序方式
  # ======== 参数 ===========
  # order_type(String) : 排序key
  # ======== 返回值 ===========
  # return String 
  def self.search_sorts(order_type)
    case order_type
    when "id_asc"
      "cash_logs.id ASC"
    else
      "cash_logs.id DESC"
    end
  end

  def self.generate_serial_no
    case self.flow_type
    when "vip_open_reward"
      # 会员开通奖励
      prefix = "L1"
    when "vip_renewal"
      # 会员续费
      prefix = "L2"
    when "vip_renewal_reward"
      # 会员续费奖励
      prefix = "L3"
    when "vip_promotion_reward"
      # 会员推广奖励
      prefix = "L4"
    when "task_promotion_reward"
      # 推广用户完成任务奖励
      prefix = "L5"
    when "point_exchange"
      # 爆点兑换
      prefix = "LA"
    when "point_recharge"
      # 爆点充值
      prefix = "LB"
    when "cash_draw_pinded"
      # 本金/押金提现(待开始）
      prefix = "LH"
    when "cash_draw_succeed"
      # 本金/押金提现（成功）
      prefix = "LJ"
    when "cash_draw_failed"
      # 本金/押金提现（失败）
      prefix = "LK"
    when "cash_recharge_succeed"
      # 押金充值
      prefix = "LL"
    when "cash_adjust_succeed"
      # 押金（爆点）调整
      prefix = "LM"
    when "issue_publish"
      # （商家）发布任务
      prefix = "LR"
    when "issue_cancel"
      # （商家）取消任务
      prefix = "LS"
    when "issue_audite_fail"
      # 商家任务审核失败
      prefix = "LT"
    when "task_start"
      # （买手）接任务
      prefix = "MA"
    when "task_cancel"
      # （买手）放弃任务
      prefix = "MB"
    when "newer_task_reward"
      # 新手任务奖励
      prefix = "MC"
    when "task_finish_buyer_freeze"
      # （买手）完成任务得到冻结的爆点
      prefix = "MD"
    when "task_finish_buyer_receive"
      # （买手）完成任务得到爆点和垫付金额
      prefix = "ME"
    when "task_finish_seller_payment"
      # （商家）完成任务
      prefix = "MF"
    when "task_deduct_insurance"
      # 扣除任务保证金
      prefix = "MG"
    when "issue_publish_commission"
      # （商家）发布任务佣金
      prefix = "MN"
    when "task_finished_commission"
      # 完成任务佣金
      prefix = "MP"
    when "point_excharge_commission"
      # 爆点兑换佣金
      prefix = "MQ"
    when "task_cancel_commission"
      # 取消任务佣金
      prefix = "MR"
    when "cash_draw_commission"
      # 用户提现佣金
      prefix = "MS"
    when "cash_freeze"
      # 冻结押金解冻
      prefix = "MQ"
    else
       # 默认（其它）
      prefix = "L0"
    end
    self.serial_no = "#{prefix}00#{UniqueCode.generate}"
  end

  def save_log_items(logs)
    error_msg = ""
    if(logs.blank?)
      return {status: "failed", message: "操作记录为空"}
    else
      logs.each do |log|
        
      end
    end
  end

  def set_operater_id
    self.operater_id = User.current_id
  end
end