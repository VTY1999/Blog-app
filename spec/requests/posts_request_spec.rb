require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'index' do
    before(:example) { get user_posts_path(1) }

    it 'return response status 200 or ok' do
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:ok)
    end

    it 'return response body text' do
      expect(response.body).to include('Posts Homepage')
    end

    it 'should render template index' do
      expect(response).to render_template('index')
    end
  end

  describe 'show' do
    before(:example) { get user_post_path(1, 1) }

    it 'return response status 200 or ok' do
      expect(response).to have_http_status(:success)
    end

    it 'return response body text' do
      expect(response.body).to include('Show a single post')
    end

    it 'should render template show' do
      expect(response).to render_template('show')
    end
  end
end
