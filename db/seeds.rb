# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

BklArea.all.each do |bkl|
  area = Area.new
  area.taobao_id = bkl.taobao_id
  area.name = bkl.name
  area.parent_id = bkl.parent_id
  area.pinyin = bkl.pinyin
  area.zipcode = bkl.zipcode
  begin
    area.save
    puts "id: #{area.id}"
  rescue
    puts "bkl error: #{bkl.id}, name: #{bkl.name}"
  end
end