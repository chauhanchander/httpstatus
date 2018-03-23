require 'httpstatus'
require 'spec_helper'
RSpec.describe httpstatus do
  it "has a version number" do
    expect(httpstatus::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
