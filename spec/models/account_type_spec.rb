require 'spec_helper'

describe AccountType do
  context "belongs to association" do
    [
      {:name => :platform},
      {:name => :updater, class_name: "User"}
    ].each do |item|
      shoulda_belongs_to(item)
    end
  end

  context "has_many association" do
    [
      {:name => :price_ranges},
      {:name => :issues},
      {:name => :accounts}
    ].each do |item|
      shoulda_has_many(item)
    end
  end
end