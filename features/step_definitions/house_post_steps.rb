# features/step_definitions/house_post_steps.rb

  Given("I am on the CaseVelocii homepage") do
    visit root_path
  end
  
  Given("I am logged in") do
    user = User.create(email: "user@example.com", password: "password", password_confirmation: "password")
    
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
  
  When("I click on the user icon") do 
    find(".profile-container").click
  end
  
  When("I click on My Houses") do 
    find('a.dropdown-item', text: 'My Houses').click

  end

  
  Then("I should see a list of my houses") do
    expect(page).to have_content("My Houses")
  end

  And("I click on Post a New House") do 
    find('a.btn.btn-primary', text: 'Post a New House').click
  end
  
  Then("I should be able to fill out the form") do
    expect(page).to have_selector("form")
  end
  
  When("I enter all the information required") do
    fill_in "post_title", with: "Beautiful Villa"
    fill_in "post_description", with: "A beautiful villa."
    fill_in "post_location_attributes_address", with: "Via Appia Nuova, 572, 00179 Roma RM"
    select "Rome", from: "post_city"
    fill_in "post_price", with: "500000"
    fill_in "post_numer_rooms", with: "5"
    fill_in "post_square_meters", with: "250"
    fill_in "post_floor", with: "2"
  end
  
  When("I upload one or more pictures") do
    attach_file("post[photos][]", Rails.root + "app/assets/images/appartment1.png")
  end
  
  When("I click on {string}") do |button|
    click_button button
  end
  
  Then("I should see a confirmation message that the post has been successfully created") do
    expect(page).to have_content("Post was successfully created.")
  end
  
  When("I visit My Houses again") do 
    find(".profile-container").click
    find('a.dropdown-item', text: 'My Houses').click
  end
  
  And ("I should see the House post I’ve just created") do
    expect(page).to have_content("Beautiful Villa")
  end
  
  Then("I click on the house I’ve just created") do
    within(find('.card', text: "Beautiful Villa")) do
        click_link 'Show'
    end
  end
  
  Then("I should see all the details about the house") do
    within('.information.col-md-6') do
      expect(page).to have_content("Address:")
      expect(page).to have_content("City:")
      expect(page).to have_content("Number of Rooms:")
      expect(page).to have_content("Price:")
      expect(page).to have_content("Square Meters:")
      expect(page).to have_content("Floor Number:")
    end
  end
  
  Then("they should be correct") do
    within('.information.col-md-6') do
        expect(page).to have_content('Address: Via Appia Nuova, 572, 00179 Roma RM')
        expect(page).to have_content('City: Rome')
        expect(page).to have_content('Number of Rooms: 5')
        expect(page).to have_content('Price: $500,000.00')
        expect(page).to have_content('Square Meters: 250.0')
        expect(page).to have_content('Floor Number: 2')
    end
  end
  
  
  
