require 'spec_helper'

describe AccountLog do
  context "belongs to association" do
    [
      {:name => :account},
      {:name => :updater, class_name: "User"}
    ].each do |item|
      shoulda_belongs_to(item)
    end
  end
end