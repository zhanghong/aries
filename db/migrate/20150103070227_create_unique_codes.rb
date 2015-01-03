class CreateUniqueCodes < ActiveRecord::Migration
  def change
    create_table :unique_codes do |t|
      t.timestamps null: false
    end
  end
end
