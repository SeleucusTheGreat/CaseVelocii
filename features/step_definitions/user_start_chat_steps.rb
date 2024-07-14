
  
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
  

