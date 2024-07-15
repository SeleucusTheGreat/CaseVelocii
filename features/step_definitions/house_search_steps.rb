
  
  When('I enter my address and a specific radius of distance in the Search bar') do
    @user2 = User.create(full_name: "user2", email: "user2@example.com", password: "password", password_confirmation: "password")
    @post = Post.create(title: "House in Rome", description:"my house",city:"Rome",price:"500000",numer_rooms:8,square_meters:"120",floor:3, user_id: @user2.id)
    location = Location.new(address:"Via Appia Nuova, 572, 00179 Roma RM")
    @post.location = location
    fill_in 'address', with: 'Via Appia Nuova, 200, 00179 Roma RM'
    fill_in 'radius', with: '5'
  end
  
  And("I enter the name of my city") do
    select 'Rome', from: 'city'
  end
  
  And("I click on Search") do
    click_button 'Search'
  end
  
  Then('I should see posts regarding houses in my city') do
    expect(page).to have_css('div.p-3.mb-5.bg-light.rounded.card', text: 'Rome')
  end
  
  And('the posts should be within the specified radius of my address') do
    post_address = find('.card-body.bg-light p.card-text', text: /Address:/).text.split('Address:').last.strip
    location2 = Location.new(address: post_address)
    search_address = 'Via Appia Nuova, 200, 00179 Roma RM'
    search_radius = 5 
    within_radius = Location.within_radius?(search_address, search_radius, location2)
    expect(within_radius).to be true
  end
  
  When('I click on one of these posts') do
    card = find('.custom-card', match: :first)
    url = card['data-url']
    visit url
  end
  
  Then('I should see detailed information about the house') do
    expect(page).to have_content('Address:')
    expect(page).to have_content('City:')
    expect(page).to have_content('Number of Rooms:')
    expect(page).to have_content('Price:')
    expect(page).to have_content('Square Meters:')
    expect(page).to have_content('Floor Number:')
  end
  
  And("I should see a map with the address of  the house displayed") do
    within('.card-body', text: 'Property Details') do
      expect(page).to have_css('img.img-fluid', count: 1)
    end
  end
  