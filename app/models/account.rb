# create_table "accounts", force: :cascade do |t|
#   t.integer  "user_id",         limit: 4,   default: 0,                      comment: "关联用户"
#   t.integer  "account_type_id", limit: 4,   default: 0,                      comment: "关联账号类型"
#   t.string   "type",            limit: 30,  default: "",                     comment: "账号类型"
#   t.integer  "platform_id",     limit: 4,   default: 0,                      comment: "平台类型ID"
#   t.string   "name",            limit: 50,  default: "",                     comment: "账号名"
#   t.string   "sub_name",        limit: 50,  default: "",                     comment: "账号辅助名，如银行卡的开户支行名，淘宝店铺掌柜ID"
#   t.string   "user_name",       limit: 30,  default: ""
#   t.string   "user_phone",      limit: 15,  default: ""
#   t.string   "status",          limit: 20,  default: "pinding",              comment: "状态"
#   t.integer  "area_id",         limit: 4,   default: 0,                      comment: "收货地区"
#   t.string   "area_name",       limit: 100, default: "",                     comment: "所在地区名"
#   t.string   "home_page",       limit: 255, default: "",                     comment: "首页URL"
#   t.string   "address",         limit: 255, default: "",                     comment: "收货地址"
#   t.string   "zipcode",         limit: 8,   default: "",                     comment: "邮编"
#   t.integer  "upload_id",       limit: 4,   default: 0,                      comment: "附件ID"
#   t.string   "memo",            limit: 255, default: "",                     comment: "备注"
#   t.string   "failed_reason",   limit: 255, default: "",                     comment: "审核失败原因"
#   t.integer  "updater_id",      limit: 4,   default: 0,                      comment: "更新用户ID"
#   t.datetime "deleted_at",                                                   comment: "删除时间"
#   t.datetime "created_at",                                      null: false
#   t.datetime "updated_at",                                      null: false
# end
# add_index "accounts", ["type", "user_id", "account_type_id"], name: "idx_by_type_user_id_and_account_type", using: :btree
# add_index "accounts", ["type", "user_id", "platform_id"], name: "idx_by_type_user_id_and_platform_id", using: :btree
class Account < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :account_type
  belongs_to  :area
  belongs_to  :updater, class_name: "User"

  has_many  :account_logs

  validates :user_id, presence: true
  validates :account_type_id, presence: true
  validates :name,  presence: true, uniqueness: {scope: [:user_id], conditions: -> { where(deleted_at: nil)}},
                    length: {maximum: 50}

  before_save :set_updater_id
  before_save :set_area_name

  STATUS = [["未审核", "pinding"], ["已审核", "actived"], ["审核失败", "failed"], ["已冻结", "freezed"], ["可编辑", "editabled"]]
  FAILED_REASONS = [["该买号为危险账号，请修改绑号信息", "danger_account"], ["收货地址不真实，请修改绑号信息", "error_address"]]

  state_machine :state, :initial => :pinding do
    event :active do
      transition [:pinding, :freezed] => :actived
    end

    event :fail do
      transition :pinding => :failed
    end

    event :freeze do
      transition [:pinding, :actived] => :freezed
    end

    event :editable do
      transition [:actived, :failed] => :editabled
    end
  end

  def find_mine(params)
    conditions = search_conditions(params)
    order_str = search_sorts(params[:order_type])
    self.join(:platform, :users).where()
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
        when "order_type"
          next
        when "id", "user_id", "state"
          conds[0] << "accounts.#{key} = ?"
          conds << val
        when "vip_level"
          conds[0] << "users.vip_months" = val
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
      "accounts.id ASC"
    else
      "accounts.id DESC"
    end
  end

  # 设置更新用户ID
  def set_updater_id
    self.updater_id = User.current_id
  end

  def set_area_name
    if self.area_id.present?
      self.area_name = self.area.full_name
    end
  end
end