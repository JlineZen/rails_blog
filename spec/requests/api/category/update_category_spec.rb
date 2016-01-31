require 'rails_helper'

describe 'PUT update category' do
	let!(:category1) { FactoryGirl.create(:category, id: 1, name: 'some') }
	let(:id) { category1.id }
	let(:params) do
		{
			category: {
				id: id,
				name: 'update name'
			}
		}
	end

	before do
		put "/api/categories/#{id}", params, { :format => 'json' }
	end

	context 'update category' do
		context 'when the id was found' do
			context 'when it update success' do
				it 'should return status 201' do
					expect(response.status).to eql 201
				end

				it 'should return success message' do
					expect(json_body['message']).to eql 'success'
				end
			end
		end

		context 'when the id was not found' do
			let(:params) do
				{
					category: {
						id: 99999,
						name: 'update name'
					}
				}
			end

			before do 
				put "/api/categories/9999", params, { :format => 'json' }
			end

			it 'should return 422 status' do
				expect(response.status).to eql 422
			end

			it 'should return a error message' do
				expect(json_body['error']).to eql 'Category not found'
			end
		end

		context 'when it have dority params' do
			context 'when it\'s id was found' do
				let(:params) do
					{
						category: {
							id: id,
							name: 'update name',
							due_date: '2016-10-10'
						}
					}
				end

				before do
					put "/api/categories/#{id}", params, { :format => 'json' }					
				end

				it 'should return status 201' do
					expect(response.status).to eql 201
				end
			end
		end
	end

	def json_body
		JSON.parse(response.body)
	end
end