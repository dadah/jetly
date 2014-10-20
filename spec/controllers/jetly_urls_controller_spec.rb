require 'rails_helper'

describe JetlyUrlsController do
  describe '#index' do

    before do
      get :index
    end

    it 'should instanciate a jetly_url' do
      expect(assigns(:jetly_url)).to be_a_new(JetlyUrl)
    end

    it 'should render jetly index' do
      expect(response).to render_template(:index)
      expect(response).to have_http_status(:success)
    end

  end

  describe '#create' do

    after do
      expect(response).to render_template(:index)
    end

    context 'When shortening a valid url' do
      let(:url_to_shorten) { 'http://www.sapo.pt' }
      let(:jetly_url) {
        mock_model 'JetlyUrl', complete_url: url_to_shorten, url_hash: 'shrt', visits: 0
      }

      it 'should fetch a shortened url' do
        allow(JetlyUrl).to receive(:create).with(complete_url: url_to_shorten).and_return(jetly_url)
        post :create, jetly_url: { complete_url: url_to_shorten }
        expect(assigns(:jetly_url)).to be(jetly_url)
      end

      context 'and it has already been shortened' do
        it 'should return the existing shortened url' do
          allow(JetlyUrl).to receive(:find_by).with(complete_url: url_to_shorten).and_return(jetly_url)
          expect(JetlyUrl).not_to receive(:create)
          post :create, jetly_url: { complete_url: url_to_shorten }
          expect(assigns(:jetly_url)).to be(jetly_url)
        end
      end
    end

  end

  describe '#show' do
    context 'When accessing an unknown hash' do

      it 'should set error and redirect to main' do
        get :show, id: 'someunknownhash'
        expect(flash[:error]).to eq('Unknown URL')
        expect(response).to redirect_to(jetly_urls_path)
      end

    end

    context 'When accessing a known hash' do
      let(:url_to_redirect) { 'http://www.sapo.pt' }
      let(:jetly_url) {
        mock_model 'JetlyUrl', complete_url: url_to_redirect, url_hash: 'shrt', visits: 0
      }

      it 'should redirect to correspondig url' do
        expect(JetlyUrl).to receive(:find_by).with(url_hash: 'shrt').and_return(jetly_url)
        get :show, id: 'shrt'
        expect(response).to redirect_to(url_to_redirect)
      end

    end
  end
end
