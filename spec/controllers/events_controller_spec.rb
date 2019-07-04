require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  subject { described_class.new}
  let(:params) do
    {
      search: {
        location: 'test',
        magic: 'yes',
        start_date:''
      }
    }
  end
  let(:filtered_parameters) do
    { location: 'test' }
  end

  describe '#get_search_params' do
    context 'with one argument only' do
      it {
        expect(subject.send(:get_search_params,params)).to eq(
          filtered_parameters
        )
      }
    end
    context 'with specific args list as second argument' do
      it {
        expect(subject.send(:get_search_params,params,['start_date'])).to eq({})
      }
      it {
        expect(subject.send(:get_search_params,params,['location'])).to eq(
          filtered_parameters
        )
      }
    end
  end
end
