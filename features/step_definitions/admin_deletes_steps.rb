
  
  And("I am logged in as an admin") do
    
    @user2 = User.create(full_name: "user2", email: "user2@example.com", password: "password", password_confirmation: "password")
    @post = Post.create(title: "House in Rome", description:"my house",city:"Rome",price:"500000",numer_rooms:8,square_meters:"120",floor:3, user_id: @user2.id)
    location = Location.new(address:"Via Appia Nuova, 572, 00179 Roma RM")
    @post.location = location
    
    @user = User.create(email: "user@example.com", full_name: "user", password: "password", password_confirmation: "password", admin: true)
    find('.profile-container').click 
    within('.dropdown-menu.session-manager') do
        find('button', text: 'Log in').click
    end
    
    expect(page).to have_selector('#UserModal', visible: true)
    
    within('#UserModal') do
        fill_in 'user_email', with: "user@example.com" 
        fill_in 'user_password', with: "password" 
        click_button 'Continue'
    end

    expect(page).to have_content("Logged in successfully")

  end
  
 
  
  And('I click on {string}') do |link_text|
    click_link link_text
  end
  
  Then("I should see the admin dashboard") do
    expect(page).to have_content("Admin Dashboard")
  end
  
  When("I search for the post with incorrect informations") do
    click_link "Title"
  end
  
  And("I find a post with incorrect information") do
    @post_to_delete = page.all('tbody tr').first
  end
  
  Then('I click on the {string} button for that post') do |button|
    within(@post_to_delete) do
        click_button button
      end
  end
  
  Then("the post should be removed from the platform") do
    expect(Post.all).not_to include(@post)
  end
  
  And("I should see a confirmation message that the post has been successfully deleted") do
    expect(page).to have_content("Post was successfully destroyed.")
  end