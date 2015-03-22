require 'spec_helper'

describe UserInfo do
  context "belongs to association" do
    [
      {:name => :user, foreign_key: "id"},
      {:name => :freezer, class_name: "User"}
    ].each do |item|
      shoulda_belongs_to(item)
    end
  end
end