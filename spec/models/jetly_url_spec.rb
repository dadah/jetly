require 'rails_helper'

describe JetlyUrl do

  describe '#create' do

    context 'When url is invalid' do
      let(:invalid_url) { 'notaurl' }
      let(:mock_short) { mock_model('JetlyUrl', complete_url: invalid_url) }
      let(:shortened_url) { JetlyUrl.create complete_url: invalid_url }

      it 'should have appropriate error set' do
        expect(shortened_url.errors).to have_key(:complete_url)
      end

      it 'should not create hash' do
        expect(shortened_url.url_hash).to eq(nil)
      end
    end

    context 'When url is valid' do
      let(:shortened_url) { JetlyUrl.create complete_url: 'http://www.test.com' }

      context 'but needs cleanup' do
        let(:shortened_url) { JetlyUrl.create( {complete_url: ' http://thisneedscleanup.com/hello world '}) }

        it 'should strip and escape url' do
          expect(shortened_url.complete_url).to eq('http://thisneedscleanup.com/hello%20world')
        end
      end

      it 'should create a new hash' do
        expect(shortened_url.url_hash).not_to eq(nil)
      end

    end

  end

  describe '.increment visits' do
    let(:short) { JetlyUrl.create complete_url: 'http://someurl.com', visits_count: 0 }
    it 'should increment number of visits' do
      short.increment_visits
      expect(short.visits_count).to eq(1)
    end
  end

end
