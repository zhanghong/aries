require 'spec_helper'

describe PriceRange do
  context "belongs to association" do
    [
      {:name => :account_type},
      {:name => :updater, class_name: "User"}
    ].each do |item|
      shoulda_belongs_to(item)
    end
  end
end