# frozen_string_literal: true

require 'selenium-webdriver'
require 'capybara/rspec'
require_relative 'spec_helper'

RSpec.describe 'Login Tests' do
  let(:login_link) {  @driver.find(:xpath, '/html/body/div[1]/div[5]/header/div[3]/div[1]/div/div[3]/nav/div/ul/li[6]/a/div/span') }

  before(:each) do
    @driver = Capybara::Session.new(:selenium)
    @driver.visit @url
    login_link.click
  end

  context "Login with username and password" do
    # usernames = ['swapnilbiswas012@gmail.com', 'himanshi.jainn@rediffmail.com', 'saumya.saran01@gmail.com']
    usernames = ['himanshi.jainn@rediffmail.com']
    password = 'LambdaTest123'
    usernames.each do |username|
      it "should be able to login with the username and password" do
        @driver.fill_in 'input-email', visible: true, with: username
        @driver.fill_in 'input-password', visible: true, with: password
        @driver.click_button('Login')
        account_header = @driver.find(:xpath, '/html/body/div[1]/div[5]/div[1]/div/div/div[1]/h2')
        expect(account_header.text).to eql("My Account")
      end
    end
  end

  context "Login with username and incorrect password" do
    credentials = [{ username: 'swapnilbiswas012@gmail.com', password: 'LambdaTest1231' }]
    credentials.each do |user|
      it "don't should be able to login with the #{user[:username]} and #{user[:password]}" do
        @driver.fill_in 'input-email', visible: true, with: user[:username]
        @driver.fill_in 'input-password', visible: false, with: user[:password]
        @driver.click_button 'Login'
        error_message = @driver.find('div.alert:nth-child(2)')
        expect(error_message.text).to include("Warning: No match for E-Mail Address and/or Password.")
      end
    end
  end
end