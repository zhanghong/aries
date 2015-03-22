require 'spec_helper'

describe UserLogin do
  context "belongs to association" do
    [
      {:name => :user}
    ].each do |item|
      shoulda_belongs_to(item)
    end
  end
end