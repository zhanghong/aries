require 'spec_helper'

describe Platform do
  context "has_many association" do
    [
      {:name => :tasks},
      {:name => :issues},
      {:name => :account_types},
      {:name => :accounts}
    ].each do |item|
      shoulda_has_many(item)
    end
  end
end