require 'spec_helper'

describe Data::Category do

	it 'is invalid without a name' do
		expect(build(:data_category, name: nil)).to have(1).errors_on(:name)
	end

	it 'is valid with a name, parent_id and description' do
		expect(build(:data_category)).to be_valid
	end

end
