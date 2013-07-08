require 'spec_helper'

describe Album do
  subject(:album) {build(:album)}

  describe 'validation' do
    it 'requires a name' do
      expect(subject).to be_valid
      subject.name = nil
      expect(subject).to be_invalid
    end
    it 'requires an img_url' do
      expect(subject).to be_valid
      subject.img_url = nil
      expect(subject).to be_invalid
    end
  end

  describe 'associations' do
    it 'knows owning users' do
      subject.users.should eq []
      expect(subject).to respond_to(:users)
    end

    it 'has songs' do
      subject.songs.should eq []
      expect(subject).to respond_to(:songs)
    end

    it 'has artists' do
			subject.artists.should eq []
      expect(subject).to respond_to(:artists)
    end
  end
end
