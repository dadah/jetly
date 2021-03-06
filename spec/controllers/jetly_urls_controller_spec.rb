require 'rails_helper'

describe JetlyUrlsController do
  describe '#index' do

    before do
      get :index
    end

    it 'instanciates a jetly_url' do
      expect(assigns(:jetly_url)).to be_a_new(JetlyUrl)
    end

    it 'renders jetly index' do
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
        mock_model 'JetlyUrl', complete_url: url_to_shorten, url_hash: 'shrt', visits_count: 0
      }

      it 'fetches a shortened url' do
        allow(JetlyUrl).to receive(:create).with(complete_url: url_to_shorten).and_return(jetly_url)
        post :create, jetly_url: { complete_url: url_to_shorten }
        expect(assigns(:jetly_url)).to be(jetly_url)
      end

      context 'and it has already been shortened' do
        it 'returns the existing shortened url' do
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

      it 'sets error and redirects to main' do
        get :show, id: 'someunknownhash'
        expect(flash[:error]).to eq('Unknown URL')
        expect(response).to redirect_to(jetly_urls_path)
      end

    end

    context 'When accessing a known hash' do
      let(:url_to_redirect) { 'http://www.sapo.pt' }
      let(:jetly_url) {
        mock_model 'JetlyUrl', complete_url: url_to_redirect, url_hash: 'shrt', visits_count: 0
      }

      it 'redirects to correspondig url and increment visits' do
        expect(JetlyUrl).to receive(:find_by).with(url_hash: 'shrt').and_return(jetly_url)
        expect(jetly_url).to receive(:increment_visits)
        get :show, id: 'shrt'
        expect(response).to redirect_to(url_to_redirect)
      end

    end
  end
end
