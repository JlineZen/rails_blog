require 'rails_helper'

describe 'GET all categories' do
	before do
		FactoryGirl.create(:category, id: 1, name: 'some name')
		FactoryGirl.create(:category, id: 2, name: 'any name')
		get '/api/categories', { :format => 'json' }
	end

	it 'return status 200' do
		expect(response.status).to eq 200
	end

	it 'return 2 category object' do
		expect(json_body.length).to eq 2
	end

	it 'should return category object attributes' do
		expect(json_body.first.keys).to eq ['id', 'name']
	end

	def json_body
		JSON.parse(response.body)
	end
end