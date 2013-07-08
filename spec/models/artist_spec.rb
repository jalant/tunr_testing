require 'spec_helper'

describe Artist do
  subject(:artist) {Artist.new(name: 'Mohit Chauhan', url: 'Chauhan.com')}

  describe 'validation' do
    it 'requires a name' do
      expect(subject).to be_valid
      subject.name = nil
      expect(subject).to be_invalid
    end
    it 'requires an img_url' do
      expect(subject).to be_valid
      subject.url = nil
      expect(subject).to be_invalid
    end
  end

  describe 'associations' do
    it 'has albums' do
      subject.albums.should eq []
      expect(subject).to respond_to(:albums)
    end
    it 'has songs' do
      subject.songs.should eq []
      expect(subject).to respond_to(:songs)
    end
  end
end
