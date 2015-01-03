class CreatePropertyRanges < ActiveRecord::Migration
  def change
    create_table :property_ranges do |t|
      t.integer  :issue_id,   default: 0, comment: '所属任务'
      t.string  :name,   default: "", comment: '属性名'
      t.string  :content,   default: "", comment: '属性值'
      t.string  :memo,   default: "", comment: '属性值辅助'
      t.integer  :need_number,   default: 0, comment: '分配的task数量'
      t.integer  :did_number,   default: 0, comment: '已开始task数量'
      t.decimal  :per_point,   precision: 5, scale: 2, comment: '每单额外价格'
      t.timestamps null: false
    end
    add_index :property_ranges, :issue_id,  name: "idx_by_issue_id"
  end
end
