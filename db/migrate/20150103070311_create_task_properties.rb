class CreateTaskProperties < ActiveRecord::Migration
  def change
    create_table :task_properties do |t|
      t.integer  :task_id,   default: 0, comment: '关联task'
      t.integer  :property_range_id,   default: 0, comment: '关联分布任务'
      t.decimal  :per_point,   precision: 5, scale: 2, comment: '额外价格'
      t.timestamps null: false
    end
    add_index :task_properties, :task_id, name: "idx_by_task_id_and_property_range_id"
  end
end
