require 'spec_helper'

describe Task do
  context "belongs to association" do
    [
      {:name => :platform},
      {:name => :issue},
      {:name => :parent_issue, class_name: "Issue"},
      {:name => :seller, class_name: "User"},
      {:name => :buyer, class_name: "User"},
      {:name => :seller_account, class_name: "Account"},
      {:name => :buyer_account, class_name: "Account"},
      {:name => :updater, class_name: "User"}
    ].each do |item|
      shoulda_belongs_to(item)
    end
  end

  context "has_many association" do
    [
      {:name => :task_properties},
      {:name => :task_products},
      {:name => :task_logs},
      {:name => :logistic_orders}
    ].each do |item|
      shoulda_has_many(item)
    end
  end
end