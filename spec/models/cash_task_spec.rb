require 'spec_helper'

describe CashTask do
  context "belongs to association" do
    [
      {:name => :user},
      {:name => :updater, class_name: "User"}
    ].each do |item|
      shoulda_belongs_to(item)
    end
  end
end