# create_table "account_types", force: :cascade do |t|
#   t.string   "type",        limit: 20,  default: "",                     comment: "种类"
#   t.integer  "platform_id", limit: 4,   default: 0,                      comment: "平台类型ID"
#   t.string   "name",        limit: 20,  default: "",                     comment: "类型名"
#   t.string   "image",       limit: 255, default: "",                     comment: "图片"
#   t.string   "icon_url",    limit: 150, default: "",                     comment: "icon图标URL"
#   t.integer  "limit_count", limit: 4,   default: 1,                      comment: "每个用户可绑定的数量"
#   t.string   "state",      limit: 20,  default: "actived",              comment: "状态"
#   t.integer  "updater_id",  limit: 4,   default: 0,                      comment: "编辑管理员"
#   t.datetime "deleted_at",                                               comment: "删除时间"
#   t.datetime "created_at",                                  null: false
#   t.datetime "updated_at",                                  null: false
# end
# add_index "account_types", ["platform_id", "name"], name: "idx_by_platform_id_and_name", using: :btree
class AccountType < ActiveRecord::Base
  belongs_to  :updater, class_name: "User"
  has_many    :accounts

  before_save :set_updater_id
  before_update :set_updater_id

  STATES = [["可用", "actived"], ["不可用", "disabled"]]

  state_machine :state, :initial => :actived do
    event :active do
      transition :disabled => :actived
    end

    event :disable do
      transition :actived => :disabled
    end

    before_transition do: :set_updater_id
  end

  # 自定义查询
  # ======== 参数 ===========
  # params(Hash) : 查询参数
  # ======== 返回值 ===========
  # return Array
  def self.find_mine(params)
    conditions = search_conditions(params)
    where(conditions)
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
        when "id", "status", "type"
          conds[0] << "#{key} = ?"
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
      "account_types.id ASC"
    else
      "account_types.id DESC"
    end
  end

  # 设置更新用户ID
  def set_updater_id
    self.updater_id = User.current_id
  end
end