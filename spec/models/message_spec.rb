require 'spec_helper'

describe Message do
  context "belongs to association" do
    [
      {:name => :user},
      {:name => :sender, class_name: "User"},
      {:name => :updater, class_name: "User"}
    ].each do |item|
      shoulda_belongs_to(item)
    end
  end
end