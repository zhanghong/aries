require 'spec_helper'

describe Area do
  context "has_many association" do
    [
      {:name => :users},
      {:name => :accounts}
    ].each do |item|
      shoulda_has_many(item)
    end
  end
end