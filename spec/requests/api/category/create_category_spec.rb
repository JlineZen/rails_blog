require 'rails_helper'

describe 'POST create category' do
	let!(:category) { FactoryGirl.create(:category, name: 'some') }
	let(:params) do 
		{
			category: {
				name: 'some name'
			}
		} 
	end

	before do
		post '/api/categories', params, { :format => 'json' }
	end

	context 'when it create success' do
		it 'should return status 201' do
			expect(response.status).to eq 201
		end

		it 'should return a success message' do
			expect(json_body['message']).to eq 'success'
		end
	end

	context 'when it already have exist the create category name' do
		let(:params) do 
			{
				category: {
					name: 'some'
				}
			} 
		end

		before do
			post '/api/categories', params, { :format => 'json' }
		end

		it 'should return status 422' do
			expect(response.status).to eq 422
		end

		it 'should return a error message' do
			expect(json_body['error']).to eq 'category already exist'
		end
	end

	def json_body
		JSON.parse(response.body)
	end
end