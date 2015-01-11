require 'spec_helper'

describe Product do
  context "belongs to association" do
    [
      {:name => :issue}
    ].each do |item|
      shoulda_belongs_to(item)
    end
  end
end