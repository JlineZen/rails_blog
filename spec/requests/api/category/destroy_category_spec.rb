require 'rails_helper'

describe 'delete category' do
	let!(:category) { FactoryGirl.create(:category, id: 1, name: 'some') }
	let(:id) { category.id }

	before do
		delete "/api/categories/#{id}", { :format => 'json', :id => id }
	end

	context 'when the id was found' do
		it 'delete success' do
			expect(response.status).to eql 204
		end

		it 'return nothing' do
			expect(response.body).to eql ""
		end
	end

	context 'when the id was not found' do
		let(:id) { 9999999 }

		before do
			delete "/api/categories/#{id}", { :format => 'json', :id => id }
		end

		it 'delete failure' do
			expect(response.status).to eql 422
		end

		it 'return error message' do
			expect(json_response['error']).to eql "Category not found"
		end
	end

	def json_response
		JSON.parse(response.body)
	end
end