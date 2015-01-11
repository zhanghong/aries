require 'spec_helper'

describe TaskProduct do
  context "belongs to association" do
    [
      {:name => :task},
      {:name => :buyer_account, class_name: "Account"},
      {:name => :seller_account, class_name: "Account"},
      {:name => :buyer, class_name: "User"},
      {:name => :seller, class_name: "User"}
    ].each do |item|
      shoulda_belongs_to(item)
    end
  end
end