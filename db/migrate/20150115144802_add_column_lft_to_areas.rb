class AddColumnLftToAreas < ActiveRecord::Migration
  def change
    add_column  :areas, :children_count,  :integer, default: 0, after: "pinyin"
    add_column  :areas, :lft,             :integer, default: 0, after: "children_count"
    add_column  :areas, :rgt,             :integer, default: 0, after: "lft"
    add_column  :areas, :depth,           :integer, default: 0, after: "rgt"
  end
end
