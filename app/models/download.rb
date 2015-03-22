# create_table "downloads", force: :cascade do |t|
#   t.integer  "user_id",      limit: 4,     default: 0,               comment: "所属用户ID"
#   t.string   "status",       limit: 30,    default: "",              comment: "下载文件状态"
#   t.string   "target_type",  limit: 30,    default: "",              comment: "下载任务类型"
#   t.text     "conditions",   limit: 65535,                           comment: "下载条件"
#   t.integer  "record_count", limit: 4,     default: 0,               comment: "下载数据条数"
#   t.string   "file_path",    limit: 100,   default: "",              comment: "下载文件路径"
#   t.integer  "file_size",    limit: 4,     default: 0,               comment: "文件大小"
#   t.integer  "down_count",   limit: 4,     default: 0,               comment: "下载次数"
#   t.datetime "created_at",                              null: false
#   t.datetime "updated_at",                              null: false
# end
# add_index "downloads", ["target_type", "user_id"], name: "idx_by_target_type_and_user_id", using: :btree
# add_index "downloads", ["user_id"], name: "idx_by_user_id", using: :btree
class Download < ActiveRecord::Base
  belongs_to  :user
  has_many    :download_logs

  TARGET_TYPES = [["物流单", "logistic_order"], ["账务明细", "cash_log"]]

  def save_export_file(target_type, params, headers, records)
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet
    odd_format = Spreadsheet::Format.new  :pattern_bg_color => "white", :color => "black", :pattern_fg_color => "white", :pattern => 1
    even_format = Spreadsheet::Format.new :pattern_bg_color => "gray", :color => "white", :pattern_fg_color => "gray", :pattern => 1
    title_format = Spreadsheet::Format.new :weight => :bold, :size => 18
    bold = Spreadsheet::Format.new(:weight => :bold)

    sheet.row(0).concat(headers.collect{|h| h.last})
    records.each_with_index do |record, idx|
      vals = []
      headers.each_with_index do |attr_item, col|
        vals << record.send(attr_item.first)
      end

      row_number = idx + 1
      sheet.row(row_number).concat(vals)

      if idx.even?
        sheet.row(row_number).default_format = even_format
      else
        sheet.row(row_number).default_format = odd_format
      end
    end

    file_path = File.join(Rails.root, "downloads/#{self.id}.xls")
    book.write file_path
    file_path
  end
end