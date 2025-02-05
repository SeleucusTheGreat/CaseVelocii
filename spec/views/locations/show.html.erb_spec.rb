require 'rails_helper'

RSpec.describe "locations/show", type: :view do
  before(:each) do
    assign(:location, Location.create!(
      name: "Name",
      address: "Address",
      latitude: 2.5,
      Longitude: 3.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/3.5/)
  end
end
