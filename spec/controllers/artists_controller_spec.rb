require 'spec_helper'

describe ArtistsController do

  describe 'collection' do
    describe 'GET #index' do
      it 'gets all of the artists' do
        artist = create(:artist)
        artist2 = create(:artist2)
        get :index
        assigns(:artists).should eq [artist, artist2]
      end
      it 'renders the :index view' do
        get :index
        response.should render_template :index
      end
    end

    describe 'GET #new' do

      let(:artist) {mock_model(Artist).as_new_record}

      before do
        Artist.stub(:new).and_return(artist)
      end

      it 'saves a new artist as an instance variable' do
        get :new
        assigns(:artist).should be_instance_of Artist
        assigns(:artist).should be_new_record
      end
      it 'renders the :new view' do
        get :new
        response.should render_template :new
      end
    end

    describe 'POST #create' do
      let(:artist) {mock_model(Artist).as_null_object}

      before do
        Artist.stub(:create).and_return(artist)
      end

      context 'with valid attributes' do

        it 'saves the artist' do
          artist.should_receive(:save)
          post :create
        end

        it 'redirects to artists index page' do
          post :create
          response.should redirect_to artists_path
        end

      end

      context 'when save fails' do
        it 'renders new page' do
          artist.should_receive(:save).and_return(false)
          post :create
          response.should redirect_to new_artist_path
        end
      end


      # it 'creates a new artist' do
      #   expect{
      #     post :create, {artist: attributes_for(:artist)}
      #   }.to change{Artist.count}.by(1)
      # end
      # it 'redirects to artists index page' do
      #   post :create, {artist: attributes_for(:artist)}
      #   response.should redirect_to artists_path
      # end
    
    context 'with invalid attributes' do
      # it 'does not create a new artist' do
      #   expect{
      #     post :create, {artist: attributes_for(:invalid_artist)}
      #   }.to change{Artist.count}.by(0)
      # end
      # it 'renders the :new view' do
      #   post :create, {artist: attributes_for(:invalid_artist)}
      #   response.should redirect_to new_artist_path
      # end
    end
  end
end

#==============================================================================

describe 'member' do
  let(:artist) {create(:artist)}
  describe 'GET #edit' do
    before do
      get :edit, id: artist
    end
    it 'saves the given artist as an instance variable' do
      assigns(:artist).should eq artist
    end
    it 'renders the :edit view' do
      response.should render_template :edit
    end
  end

  describe 'GET #show' do
    before do
      get :show, id: artist
    end
    it 'shows a particular artist' do
      assigns(:artist).should eq artist
    end
    it 'renders the :show view' do
      response.should render_template :show
    end
  end

  describe 'PUT #update' do
    #before do.. what?
    context 'valid attributes' do
      let(:artist) {create(:artist)}
      let(:valid_update_artist) {create(:valid_update_artist)}
      it 'assigns the given artist to an instance variable' do
        put :update, {id: artist, artist: attributes_for(:valid_update_artist)}
        assigns(:artist).should eq artist
      end
      it 'changes the attributes of the artist' do
        put :update, {id: artist, artist: attributes_for(:valid_update_artist)}
        artist.reload
        artist.name.should eq valid_update_artist.name
        artist.url.should eq valid_update_artist.url
      end
      it 'redirects to the artist page' do
        put :update, {id: artist, artist: attributes_for(:valid_update_artist)}
        response.should redirect_to artist
      end
    end

    context 'invalid attributes' do
      let(:invalid_update_artist) {build(:invalid_update_artist)}

      it 'assigns the given artist to an instance variable' do
        put :update, {id: artist, artist: attributes_for(:invalid_update_artist)}
        assigns(:artist).should eq artist
      end
      it 'does not change the attributes of the artist' do
        put :update, {id: artist, artist: attributes_for(:invalid_update_artist)}
        assigns(:artist).name.should_not eq invalid_update_artist.name
        assigns(:artist).url.should_not eq invalid_update_artist.url
      end
      it 're-renders the edit page' do
        put :update, {id: artist, artist: attributes_for(:invalid_update_artist)}
        response.should redirect_to edit_artist_path
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the artist' do
      artist.reload
      expect{
        delete :destroy, id: artist
      }.to change{Artist.count}.by(-1)
    end
    it 'redirects to the artists index page' do
      delete :destroy, id: artist
      response.should redirect_to artists_path
    end

  end

end

end
