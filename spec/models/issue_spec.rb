require 'spec_helper'

describe Issue do
  context "belongs to association" do
    [
      {:name => :user},
      {:name => :platform},
      {:name => :account_type},
      {:name => :parent,  class_name: "Issue"},
      {:name => :template,  class_name: "Issue"}
    ].each do |item|
      shoulda_belongs_to(item)
    end
  end

  context "has_many association" do
    [
      {:name => :tasks},
      {:name => :property_ranges},
      {:name => :products},
      {:name => :issue_services},
      {:name => :issue_schedulers},
      {:name => :issue_logs},
      {:name => :children,  class_name: "Issue",  foreign_key: "parent_id"},
      {:name => :template_children, class_name: "Issue", foreign_key: "template_id"},
      {:name => :all_tasks, class_name: "Task", foreign_key: "parent_id"}
    ].each do |item|
      shoulda_has_many(item)
    end
  end
end