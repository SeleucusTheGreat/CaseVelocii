Given("the following user exists:") do |table|
    user_attributes = table.rows_hash
    @user = User.create!(user_attributes)
  end
  
  Given("I am logged in as {string} with password {string}") do |email, password|
    visit root_path
    
    
    find('.profile-container').click 
    

    within('.dropdown-menu.session-manager') do
        find('button', text: 'Log in').click
    end

    expect(page).to have_selector('#UserModal', visible: true)

   
    within('#UserModal') do
        fill_in 'user_email', with: email 
        fill_in 'user_password', with: password 
        click_button 'Continue'
    end
    
    
    expect(page).to have_content("Logged in successfully")
  end
  
  Given("the following posts exist for the user {string}:") do |email, table|
    user = User.find_by(email: email)
    attr=table.rows_hash
    post_attributes = attr.dup
    address = post_attributes.delete(:address) 
    post_attributes.merge!(user: user)
    @post = Post.create!(post_attributes)
    location = Location.new(address: address) 
    @post.location = location
  end
  
  When("I visit the posts page") do
    visit root_path
    visit post_path(@post)
    expect(page).to have_content(@post.title)
  end
  
  Then("I should see the following posts:") do |table|
    expect(page).to have_content(@post.address)
    expect(page).to have_content(@post.city)
    expect(page).to have_content(@post.numer_rooms) 
    expect(page).to have_content(@post.price.to_s) 
    expect(page).to have_content(@post.square_feet.to_s) 
    expect(page).to have_content(@post.floor.to_s) 
end
  