require 'spec_helper'

describe Account do
  context "belongs to association" do
    [
        {:name => :user},
        {:name => :account_type},
        {:name => :platform},
      {:name => :area},
      {:name => :updater, class_name: "User"}
    ].each do |item|
      shoulda_belongs_to(item)
    end
  end

  context "has_many association" do
    [
      {:name => :account_logs},
      {:name => :buyer_task_products, class_name: "TaskProduct", foreign_key: "buyer_account_id"},
      {:name => :seller_task_products, class_name: "TaskProduct", foreign_key: "seller_account_id"},
      {:name => :seller_tasks, class_name: "Task", foreign_key: "seller_account_id"},
      {:name => :buyer_tasks, class_name: "Task", foreign_key: "buyer_account_id"}
    ].each do |item|
      shoulda_has_many(item)
    end
  end
end