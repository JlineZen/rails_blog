require 'rails_helper'

RSpec.describe Api::CategoriesController, type: :controller do
	describe 'GET #index' do
		before do
			allow(Category).to receive(:all).and_return([])
		end

		it 'sholud return a empty array' do
			get :index, { :format => 'json'}
			expect(json_body).to eq []
		end
	end

	describe 'POST #create' do
		let(:category) { FactoryGirl.create(:category, name: 'some') }
		let(:params) do 
			{
				category: {
					name: 'some name'
				}
			}
		end

		before do
			post :create, params, { :format => 'json' }
		end

		context 'when it create success' do
			it 'should return status 201' do
				expect(response.status).to eql 201
			end

			it 'should return success massage' do
				expect(json_body['message']).to eql 'success'
			end
		end

		context 'when it create with the existed name' do
			let(:params) do 
				{
					category: {
						name: 'some'
					}
				}
			end

			before do
				post :create, params, { :format => 'json' }
			end

			it 'should return status 422' do
				expect(response.status).to eql 422
			end

			it 'should return success massage' do
				expect(json_body['error']).to eql 'category already exist'
			end

			it 'should changed category count by 0' do
				expect{
					post :create, params, { :format => 'json' }
				}.to change{ Category.count }.by(0)
			end
		end
	end

	describe 'PUT #update' do
		let!(:category) { FactoryGirl.create(:category, id: 1, name: 'some') }
		let(:id) { category.id }
		let(:params) do
			{
				id: id,
				category: {
					name: 'update name' 
				}
			}
		end

		before do
			put :update, params, { :format => 'json' }
		end

		context 'when the id was found' do
			it 'should return 201 status' do
				expect(response.status).to eq 201
			end

			it 'should return success massage' do
				expect(json_body['message']).to eql 'success'
			end
		end

		context 'when the id was not found' do
			let(:id) { 9999 }
			let(:params) do
				{
					id: id,
					category: {
						name: 'update name' 
					}
				}
			end

			before do
			put :update, params, { :format => 'json' }
		end

			it 'should return 422 status' do
				expect(response.status).to eq 422
			end

			it 'should return success massage' do
				expect(json_body['error']).to eql 'Category not found'
			end
		end
	end

	describe 'delete #destroy' do
		let!(:category) { FactoryGirl.create(:category, id: 1, name: 'some') }

		before do
			delete :destroy, { :id => category.id, :format => 'json' }
		end

		context 'when the id was found' do
			it 'should return 201 status' do
				expect(response.status).to eq 204
			end

			it 'should return nothing' do
				expect(json_body['message']).to eql 'success'
			end
		end

		context 'when the id was not found' do
			before do
				delete :destroy, { :id => 9999, :format => 'json' }
			end	

			it 'should return 422 status' do
				expect(response.status).to eq 422
			end

			it 'should return success massage' do
				expect(json_body['error']).to eql 'Category not found'
			end	
		end
	end

	def json_body
		JSON.parse(response.body)
	end
end
