require 'rails_helper'

describe 'POST create category' do
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

	context 'when it create success' do

		it 'should return status 201' do
			expect(response.status).to eq 201
		end

		it 'should return a success message' do
			expect(json_body['message']).to eq 'success'
    end

    it 'should change the category column count by 1' do
      expect{
				post '/api/categories', { category: { name: 123 } }, { :format => 'json' }
      }.to change{ Category.count }.by(1)
    end
	end

	context 'when it already have exist the create category name' do
		before do
			FactoryGirl.create(:category, name: 'some')

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