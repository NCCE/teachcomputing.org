require 'rails_helper'

describe 'FutureLearn LTI routes' do
  it 'has an LTI show route' do
    expect(get('/futurelearn/lti/asdfasdf'))
      .to route_to(
        controller: 'future_learn/lti',
        action: 'show',
        fl_id: 'asdfasdf'
      )
  end
end
