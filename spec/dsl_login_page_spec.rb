# frozen_string_literal: true

require 'selenium-webdriver'
require 'capybara/rspec'
require_relative 'spec_helper'

RSpec.describe 'Login Tests' do
  include Capybara::DSL
  let(:login_lnk) {  find(:xpath, '/html/body/div[1]/div[5]/header/div[3]/div[1]/div/div[3]/nav/div/ul/li[6]/a/div/span') }

  before(:each) do
    visit @url
    login_lnk.click
  end

  context "Login with username and password" do
    # usernames = ['swapnilbiswas012@gmail.com', 'himanshi.jainn@rediffmail.com', 'saumya.saran01@gmail.com']
    usernames = ['swapnilbiswas012@gmail.com']
    password = 'LambdaTest123'
    usernames.each do |username|
      it "should be able to login with the username and password" do
        fill_in 'input-email', visible: true, with: username
        fill_in 'input-password', visible: true, with: password
        click_button 'Login'
        account_header = find(:xpath, '/html/body/div[1]/div[5]/div[1]/div/div/div[1]/h2')
        # account_header = find(:css, 'h2.card-header.h5')
        # #content > div:nth-child(1) > h2
        expect(account_header.text).to eql "My Account1"
      end
    end
  end

  context "Login with username and incorrect password" do

    it 'will do something in the future'

    credentials = [{ username: 'swapnilbiswas012@gmail.com', password: 'LambdaTest1231' }]
    credentials.each do |user|
      it "don't should be able to login with the #{user[:username]} and #{user[:password]}" do
        fill_in 'input-email', visible: true, with: user[:username]
        fill_in 'input-password', visible: true, with: user[:password]
        click_button 'Login'
        error_message = find('div.alert:nth-child(2)')
        expect(error_message.text).to include "Warning: No match for E-Mail Address and/or Password."
      end
    end
  end
end