require 'spec_helper'

describe User do
  context "belongs to association" do
    [
      {:name => :area},
      {:name => :alipay_account, class_name: "Account"},
      {:name => :tenpay_account, class_name: "Account"},
      {:name => :bank_account, class_name: "Account"},
      {:name => :invitator, class_name: "User"},
      {:name => :freezer, class_name: "User"}
    ].each do |item|
      shoulda_belongs_to(item)
    end
  end

  context "has one association" do
    [
      {:name => :user_info}
    ].each do |item|
      shoulda_has_one(item)
    end
  end

  context "has_many association" do
    [
      {:name => :user_logins},
      {:name => :weibo_orders},
      {:name => :promotions},
      {:name => :payment_orders},
      {:name => :messages},
      {:name => :issues},
      {:name => :downloads},
      {:name => :download_logs},
      {:name => :cash_tasks},
      {:name => :invitated_users, class_name: "User", foreign_key: "invitator_id"},
      {:name => :buyer_task_products, class_name: "TaskProduct", foreign_key: "buyer_id"},
      {:name => :seller_task_products, class_name: "TaskProduct", foreign_key: "seller_id"},
      {:name => :seller_tasks, class_name: "Task", foreign_key: "seller_id"},
      {:name => :buyer_tasks, class_name: "Task", foreign_key: "buyer_id"},
      {:name => :source_cash_logs, class_name: "CashLog", foreign_key: "source_id"},
      {:name => :target_cash_logs, class_name: "CashLog", foreign_key: "target_id"},
      {:name => :operated_cash_logs, class_name: "CashLog", foreign_key: "operater_id"}
    ].each do |item|
      shoulda_has_many(item)
    end
  end
end