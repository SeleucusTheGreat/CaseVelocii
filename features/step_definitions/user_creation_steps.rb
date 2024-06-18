Given("I create the following user:") do |table|
    user_attributes = table.rows_hash
    @user = User.create!(user_attributes)
  end
  
  Then("I should have the following user:") do |table|
    expected_user = table.rows_hash
    created_user = User.find_by(full_name: expected_user["full_name"])
  
    expect(created_user).not_to be_nil
    expect(created_user.full_name).to eq(expected_user["full_name"])
  end
  