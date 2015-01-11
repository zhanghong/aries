require 'spec_helper'

describe WeiboNotify do
  context "belongs to association" do
    [
      {:name => :weibo_order}
    ].each do |item|
      shoulda_belongs_to(item)
    end
  end
end