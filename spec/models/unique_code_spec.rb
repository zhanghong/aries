require 'spec_helper'

describe UniqueCode do
  context "测试生成唯一码方法" do
    it "生成的唯一码长度是6位并由0-9和A-F组成" do
      code_no = UniqueCode.generate
      expect(code_no).to match(/[0-9A-F]{6}/)
    end
  end
end