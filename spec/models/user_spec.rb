require 'rails_helper'

describe User do
	describe "Validations" do
		context "On a new user" do

			it "should not be valid without a name" do
				user = User.new email: 'abc.example.com', password: 'password', password_confirmation: 'password'
				expect(user.valid?).to eq(false)
			end
      
			it "should not be valid without an email" do
				user = User.new name: 'abc', password: 'password', password_confirmation: 'password'
				expect(user.valid?).to eq(false)
			end
			
		end
		
		context "On an existing user" do
      
			let(:user) do
				u = User.create name: 'abc', email: 'abc.example.com', password: 'password', password_confirmation: 'password'
				User.find u.id
			end
						
			it "should not be valid with an empty name" do
				user.name = ""
				expect(user.valid?).to eq(false)
			end
			
			it "should not be valid with an empty email" do
				user.email = ""
				expect(user.valid?).to eq(false)
			end
			
		end	
	end
end