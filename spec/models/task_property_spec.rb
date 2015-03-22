require 'spec_helper'

describe TaskProperty do
  context "belongs to association" do
    [
      {:name => :task},
      {:name => :property_range}
    ].each do |item|
      shoulda_belongs_to(item)
    end
  end
end