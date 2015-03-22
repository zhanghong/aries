require 'spec_helper'

describe LogisticOrder do
  context "belongs to association" do
    [
      {:name => :task},
      {:name => :updater, class_name: "User"}
    ].each do |item|
      shoulda_belongs_to(item)
    end
  end
end