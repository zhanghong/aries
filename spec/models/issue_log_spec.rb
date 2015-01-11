require 'spec_helper'

describe IssueLog do
  context "belongs to association" do
    [
      {:name => :issue},
      {:name => :updater, class_name: "User"}
    ].each do |item|
      shoulda_belongs_to(item)
    end
  end
end