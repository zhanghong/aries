# create_table "logistic_orders", force: :cascade do |t|
#   t.string   "serial_no",   limit: 20, default: "",              comment: "物流单号"
#   t.string   "company_code", limit: 6,  default: "",              comment: "物流公司编号"
#   t.datetime "used_time",                                        comment: "使用时间"
#   t.integer  "task_id",     limit: 4,  default: 0,               comment: "使用任务ID"
#   t.string   "batch_no",    limit: 12, default: "",              comment: "导出批次号"
#   t.integer  "updater_id",  limit: 4,  default: 0,               comment: "更新用户ID"
#   t.datetime "created_at",                          null: false
#   t.datetime "updated_at",                          null: false
# end
class LogisticOrder < ActiveRecord::Base
  belongs_to  :task
  belongs_to  :updater, class_name: "User"

  COMPANY_CODES = [["顺风快递", "sf"]]

  # 物流公司名
  def company_code_name
    item = COMPANY_CODES.select{|i| i.last == self.company_code}
    if item
      item.first
    else
      self.company_code
    end
  end

  # 管理员查看的物流单概况
  def self.count_admin_summary_info
    select_str = <<-SQL
      COUNT(*) AS logistic_order_total_count,
      COUNT(IF(task_id > 0 AND batch_no = '', id, NULL)) AS logistic_order_nobatch_count,
      COUNT(IF(batch_no != '', id, NULL)) AS logistic_order_batched_count,
      COUNT(IF(task_id=0, id, NULL)) AS logistic_order_unbinded_count
    SQL

    self.select(select_str).first
  end

  # 管理员搜索方法
  def self.find_mine(params)
    conditions = search_conditions(params)
    sort_str = search_sorts(params[:order_type])
    self.joins(:task, :seller_account, :buyer_account).where(conditions).order(sort_str)
  end

  # 上传物流单
  def upload(upload)
    successed_count = 0
    total_count = 0
    attach = upload.attach
    file_path = attach.path

    book = Spreadsheet.open(file_path)
    sheet = book.worksheet(0)
    sheet.each do |row|
      total_count += 1
      if save_excel_line(row)
        successed_count += 1
      end
    end

    return {successed_count: successed_count, total_count: total_count}
  end

  # 导出物流单
  # params
  def batch_export(params)

  end
private
  # 给第一次导出的已使用物流单打上批次号
  def mark_first_export_record(params)
    conditions = search_conditions(params)
    new_batch_no = generate_new_batch_no

    conds = []
    conds << conditions[0] if conditions[0].present?
    conds << "logistic_orders.task_id = ?"
    conditions << 0
    conds << "logistic_orders.batch_no = ?"
    conditions << ""
    conditions[0] = conds.join(" AND ")

    update_all({batch_no: $new_batch_no}, conditions)
  end

  # 搜索条件
  def self.search_conditions(params)
    conds = [[]]
    if params.is_a?(Hash)
      case params[:status]
      when "no_batch"
        conds[0] << "logistic_orders.batch_no = ''"
        conds[0] << "logistic_orders.task_id > 0"
      when "batched"
        conds[0] << "logistic_orders.batch_no != ''"
      when "unbinded"
        conds[0] << "logistic_orders.task_id = 0"
      else
        conds[0] << "logistic_orders.id = 0"
      end

      params.each do |key, val|
        next if %w(status).include?(key)
        val = val.to_s.strip if val.is_a?(String)
        next if val.blank?
        case key.to_s
        when "batch_no"
          conds[0] << "logistic_orders.batch_no = ?"
          conds << val
        when "task_id"
          conds[0] << "logistic_orders.task_id = ?"
          conds << val
        when "ids"
          conds[0] << "logistic_orders.id IN (?)"
          conds << val
        when "area_ids"
          conds[0] << "tasks.receive_area_id IN (?)"
          conds << val
        when "area_id"
          conds[0] << "tasks.receive_area_id = ?"
          conds << val
        end
      end
    end

    if conds[0].blank?
      return []
    else
      conds[0] = conds[0].join(" AND ")
      return conds
    end
  end

  # 搜索排序方式
  def self.search_sorts(order_type)
    case order_type
    when "id_desc"
      "logistic_orders.id DESC"
    else
      "logistic_orders.id ASC"
    end
  end

  # 生成新的导出批次号
  def self.generate_new_batch_no
    date_str = Date.today.strftime("%Y%m%d")
    record = select("COUNT(DISTINCT batch_no) AS batched_count").
              where(["batch_no LIKE ?", "#{date_str}-%"]).first
    num = record["batch_no"].to_i + 1
    num.rjust(3, "0")
  end

  # 保存上传的物流记录
  def self.save_excel_line(row)
    serial_no = row[0].to_s
    return false if serial_no.blank?
    return false unless /^(\d{12})$/.match(serial_no)
    company_code = row[1].to_s
    company_code = "sf" if company_code.blank?

    item = find_or_initialize_by_serial_no(serial_no)
    if item.new_record?
      if item.update(company_code: company_code)
        return true
      else
        return false
      end
    else
      return false
    end
  end
end