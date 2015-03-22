class RenameColumnReceiveNameInAccount < ActiveRecord::Migration
  def change
    rename_column :accounts,  :receive_name,  :user_name
    rename_column :accounts,  :receive_phone,  :user_phone
  end
end
