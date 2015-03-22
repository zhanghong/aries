class AddColumnUploadIdToAccounts < ActiveRecord::Migration
  def change
    add_column  :accounts,  :upload_id, :integer, default: 0, comment: '附件ID', after: "zipcode"
    remove_column :accounts,  :picture
  end
end
