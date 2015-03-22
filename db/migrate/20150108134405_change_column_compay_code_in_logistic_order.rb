class ChangeColumnCompayCodeInLogisticOrder < ActiveRecord::Migration
  def change
    rename_column :logistic_orders, :compay_code, :company_code
  end
end
