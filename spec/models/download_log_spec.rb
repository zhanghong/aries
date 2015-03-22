require 'spec_helper'

describe DownloadLog do
  context "belongs to association" do
    [
      {:name => :download},
      {:name => :user}
    ].each do |item|
      shoulda_belongs_to(item)
    end
  end
end