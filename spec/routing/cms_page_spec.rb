require 'rails_helper'

describe 'CMS Page routes' do
  it 'has a generic route' do
    expect(get('/cms/hubs')).to route_to(controller: 'cms', action: 'cms_page', page_slug: 'hubs')
  end

  it 'has a route for generic refresh' do
    expect(get('/cms/hubs/refresh')).to route_to(controller: 'cms', action: 'clear_page_cache', page_slug: 'hubs')
  end

  it 'has a route for bursary' do
    expect(get('/bursary')).to route_to(controller: 'cms', action: 'cms_page', page_slug: 'bursary')
  end

  it 'has a route for bursary refresh' do
    expect(get('/bursary/refresh')).to route_to(controller: 'cms', action: 'clear_page_cache', page_slug: 'bursary')
  end

  it 'has a route for home-teaching' do
    expect(get('/home-teaching/key-stage-2')).to route_to(controller: 'cms', action: 'cms_page', page_slug: 'key-stage-2')
  end

  it 'has a route for home-teaching refresh' do
    expect(get('/home-teaching/key-stage-2/refresh')).to route_to(controller: 'cms', action: 'clear_page_cache', page_slug: 'key-stage-2')
  end
end
