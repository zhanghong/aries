require 'spec_helper'

describe CashLog do
  context "belongs to association" do
    [
      {:name => :source_user, class_name: "User", foreign_key: "source_id"},
      {:name => :target_user, class_name: "User", foreign_key: "target_id"},
      {:name => :operater_user, class_name: "User", foreign_key: "operater_id"}
    ].each do |item|
      shoulda_belongs_to(item)
    end
  end
end