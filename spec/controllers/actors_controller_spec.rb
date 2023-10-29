require 'rails_helper'

RSpec.describe ActorsController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new actor' do
        expect do
          post :create, params: { actor: { name: 'John Doe', age: 30, height: 180.5, rating: 8.5 } }
        end.to change(Actor, :count).by(1)

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['status']).to eq('success')
      end
    end

    context 'with invalid parameters' do
      it 'returns an error' do
        post :create, params: { actor: { name: '', age: 25, height: 170.0, rating: 9.0 } }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['status']).to eq('error')
        expect(JSON.parse(response.body)['errors']).to include("Name can't be blank")
      end
    end
  end

  describe 'PATCH #update' do
    let(:actor) { create(:actor, name: 'Old Jack', age: 35, height: 175.0, rating: 7.0) }

    context 'with valid parameters' do
      it 'updates the actor' do
        patch :update, params: { id: actor.id, actor: { name: 'New Jack', age: 40, height: 185.0, rating: 9.5 } }

        actor.reload
        expect(actor.name).to eq('New Jack')
        expect(actor.age).to eq(40)
        expect(actor.height).to eq(185.0)
        expect(actor.rating).to eq(9.5)

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['status']).to eq('success')
      end
    end

    context 'with invalid parameters' do
      it 'returns an error' do
        patch :update, params: { id: actor.id, actor: { name: '', age: 38, height: 180.0, rating: 8.0 } }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['status']).to eq('error')
        expect(JSON.parse(response.body)['errors']).to include("Name can't be blank")
      end
    end
  end
end
