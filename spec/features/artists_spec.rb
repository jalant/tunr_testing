require 'spec_helper'

describe 'Artists' do

  before do
    @artist = create(:artist)
    @artist2 = create(:artist2)
  end

  describe 'GET /' do
    it 'displays link to artist index page' do
      visit root_path
      page.should have_selector('h1')
      click_link('Artists')
      page.should_not have_selector('h1')
      page.should have_selector('h2')

    end
  end

  describe 'GET /artists' do
    it 'displays link to new_artist_page' do
      visit artists_path
      page.should have_selector('h2')
      click_link('New Artist')
      page.should_not have_selector('h2')
      page.should have_content('Create a new artist')
      find('h1').should have_content('Create a new artist')
    end
  end

  describe 'new artist page' do
    it 'displays the artist profile on success' do
      visit new_artist_path
      page.should have_selector('form')

      fill_in('Name', with: 'Tanay Jalan')
      fill_in('Url', with: 't@t.com')

      find_field('artist_name').value.should eq 'Tanay Jalan'
      click_button('Create Artist')
      current_path.should eq artists_path
      Artist.count.should eq 3
      #page.should have_content('Artist Profile')
    end
  end

  describe 'GET /artists' do
    it 'has a table with all the artists' do
      visit artists_path
      page.should have_selector('table')
      find('table').should have_selector('tr')
      find('table').should have_content(@artist.name)
      #find('table').should have_content(@artist.url)
      find('table').should have_selector('tr', :count => 2)
     find('table').should have_selector("input[value='delete']")
      find('table tr:nth-child(1) td:nth-child(2) a').click
      current_path.should eq artist_path(@artist)

    end
  end

  describe 'GET /artists' do
    it 'has a table that deletes a specific artist' do
      visit artists_path
      find('table').should have_selector("input[value='delete']")
      find("input[id='#{@artist.id}']").click
      find('table').should have_selector('tr', :count => 1)
          
    end
  end

  describe 'GET /artists/2' do
    it "has the artist's name and image url" do
      visit "/artists/#{@artist.id}"
      page.should have_content(@artist.name)
      page.should have_css("img[src='#{@artist.url}']")
    end
  end

  describe 'GET /artists/:id' do
    it "has a form to edit an artist's attributes"  do
      visit edit_artist_path(@artist)
      page.should have_selector('form')
      find('form').should have_css("input[id='artist_name']")
      find('form').should have_css("input[id='artist_url']")

      find("input#artist_name").value.should eq(@artist.name)
      find("input#artist_url").value.should have_content(@artist.url)
      
      
    end
  end

  describe 'PUT /artists/:id' do
    it "updates an artist's attributes" do

      visit edit_artist_path(@artist)

      fill_in('Name', with: 'Lee Hampton')
      fill_in('Url', with: 'l@l.com')
      click_button('Update Artist')
      @artist.reload
      current_path.should eq artist_path(@artist)
      page.should have_content(@artist.name)
      page.should have_css(("img[src='#{@artist.url}']"))

    end
  end

  # describe 'DELETE /artists/:id' do
  #   it 'deletes an artist from the database' do
  #     visit artist_path(@artist)
  #     Artist.count.should.change.by(-1)
  #   end
  # end



  #describe
end
