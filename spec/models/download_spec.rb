require 'spec_helper'

describe Download do
  context "belongs to association" do
    [
      {:name => :user}
    ].each do |item|
      shoulda_belongs_to(item)
    end
  end

  context "has_many association" do
    [
      {:name => :download_logs}
    ].each do |item|
      shoulda_has_many(item)
    end
  end
end