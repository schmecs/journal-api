require 'rails_helper'

RSpec.describe 'Posts API' do
	let!(:user) { create(:user) }
	let!(:posts) { create_list(:post, 20, user_id: user.id) }
	let(:user_id) { user.id }
	let(:id) { posts.first.id }

	describe 'GET /users/:user_id/posts' do
		before  { get "/users/#{user_id}/posts" }

		context 'when post exists' do
			it 'returns status code 200' do
				expect(response).to have_http_status(200)
			end

			it 'returns all user posts' do
				expect(json.size).to eq(20)
			end
		end

		context 'when user does not exist' do
			let(:user_id) { 0 }

			it 'returns status code 404' do
				expect(response).to have_http_status(404)
			end

			it 'returns a not found message' do
				expect(response.body).to match(/Couldn't find User/)
			end
		end
	end

	describe 'GET /users/:user_id/posts/:id' do
    before { get "/users/#{user_id}/posts/#{id}" }

    context 'when post exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the post' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when post does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Post/)
      end
    end
  end

  describe 'POST /users/:user_id/posts' do
  	let(:valid_attributes) { { content: "I am riding the train right now." } }

  	context 'when request attributes are valid' do
  		before { post "/users/#{user_id}/posts", params: valid_attributes }

  		it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
    	before { post "/users/#{user_id}/posts", params: {} }

    	it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Content can't be blank/)
      end
    end
  end

  describe 'PUT /users/:user_id/posts/:id' do
    let(:valid_attributes) { { content: 'This is my revised post content.' } }

    before { put "/users/#{user_id}/posts/#{id}", params: valid_attributes }

    context 'when item exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the item' do
        updated_post = Post.find(id)
        expect(updated_post.content).to match(/This is my revised post content./)
      end
    end

    context 'when the post does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Post/)
      end
    end
  end

  describe 'DELETE /users/:id' do
    before { delete "/users/#{user_id}/posts/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end


















