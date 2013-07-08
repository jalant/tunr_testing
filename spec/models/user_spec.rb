require 'spec_helper'

describe User do
  subject(:user) {User.new(name: 'Tanay Jalan', email: 'tanay@tanay.com')}


  describe 'validation' do
    it 'requires a name' do
      expect(subject).to be_valid
      subject.name = nil
      expect(subject).to be_invalid
    end
    it 'requires an email' do
      expect(subject).to be_valid
      subject.email = nil
      expect(subject).to be_invalid
    end
  end

  describe 'associaitons' do

    it 'has albums' do
      subject.albums.should eq []
      expect(subject).to respond_to(:albums)
    end
  end

  describe '#purchase' do
    context 'for new album' do
      it 'adds an album to collection' do
        album = create(:album)
        lambda {
          subject.purchase(album)
        }.should change{user.albums.size}.by 1
        user.albums.should eq [album]
      end
    end

    context 'for existing album' do
      it 'does not add album to collection' do
      	album = create(:album)
      	subject.purchase(album)
        lambda {
          subject.purchase(album)
        }.should change{user.albums.size}.by 0
        user.albums.should eq [album]
      end
    end
  end

  describe '#forget_albums' do
  	it 'removes all the user albums' do
  		album_1 = create(:album)
  		album_2 = create(:album)
  		subject.purchase(album_1)
  		subject.purchase(album_2)
  		
  		lambda {
          subject.forget_albums
        }.should change{user.albums.size}.by -2
  		
  		subject.albums.should eq []
  	end
  end
end