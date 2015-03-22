class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string      :related_type
      t.integer     :related_id
      t.string      :attach_file_name,    default: "",  limit: 150
      t.string      :attach_content_type, default: "",  limit: 30
      t.integer     :attach_file_size,    default: 0
      t.datetime    :attach_updated_at
      t.timestamps null: false
    end
  end
end
