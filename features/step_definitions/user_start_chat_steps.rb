
  
  Given('I am on CaseVelocii homepage') do
    visit root_path
  end
  
  When('I click on a house post that interests me') do
    @user2 = User.create(full_name: "user2", email: "user2@example.com", password: "password", password_confirmation: "password")
    @post = Post.create(title: "house", description:"my house",city:"Rome",price:"500000",numer_rooms:8,square_meters:"120",floor:3, user_id: @user2.id)
    location = Location.new(address:"Via Appia Nuova, 572, 00179 Roma RM")
    @post.location = location
    visit post_path(@post)
  end
  
  Then('I should see the details of the house post') do
    within('.information.col-md-6') do
        expect(page).to have_content("Address: Via Appia Nuova, 572, 00179 Roma RM")
        expect(page).to have_content("City: Rome")
        expect(page).to have_content("Number of Rooms: 8")
        expect(page).to have_content("Price: $500,000.00")
        expect(page).to have_content("Square Meters: 120")
        expect(page).to have_content("Floor Number: 3")
      end
  end
  
  And ("I should see a Send Message and a text box") do
    within('.col-md-8') do
      expect(page).to have_selector('textarea#content')
      expect(page).to have_button('Send Message')
    end
  end
  
  When('I write a new message') do
    fill_in 'content', with: 'Is this house still available?'
  end
  
  And ('I click on Send Message') do
    click_button 'Send Message'
  end
  
  Then('A new chat should be created between me and the House owner') do
    @chat = Chat.last
    expect(@chat.messages.last.content).to eq('Is this house still available?')
    expect(@chat.owner).to eq(@user2)
    expect(@chat.buyer).to eq(@user)
  end
  
  When('I visit my UserPage') do
    visit userpage_path
  end
  
  Then("A new chat should be visible") do
    expect(page).to have_css('div.card.h-100')
    within('div.card.h-100') do
      expect(page).to have_css('div.card-body')
      expect(page).to have_css('div.row.align-items-center')
      expect(page).to have_css('div.col-md-3.text-center.User img.rounded-circle')
      expect(page).to have_css('div.col-md-3.text-center.User h6', text: 'user2')
      expect(page).to have_css('div.col-md-3.text-center.House h6', text: 'house')
    end
  end
  
  And ("it should display the other user's profile picture and name") do
    within('div.card.h-100') do
      expect(page).to have_css('div.col-md-3.text-center.User img.rounded-circle')
      expect(page).to have_css('div.col-md-3.text-center.User h6', text: 'user2')
    end
  end
  
  And("it should show the associated post's image and title") do
    within('div.col-md-3.text-center.House') do
      expect(page).to have_css('img.rounded.mb-2')
      expect(page).to have_css('h6.mb-0', text: 'house')
    end
  end
  
  
  And("it should display the last message exchanged") do
    expect(page).to have_content('Is this house still available?')
  end

