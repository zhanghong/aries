require 'spec_helper'

describe PropertyRange do
  context "belongs to association" do
    [
      {:name => :issue}
    ].each do |item|
      shoulda_belongs_to(item)
    end
  end

  context "has_many association" do
    [
      {:name => :task_properties}
    ].each do |item|
      shoulda_has_many(item)
    end
  end
end