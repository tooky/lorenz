require 'spec_helper'

describe 'a three wheel encryption mechanism' do
  let(:machine) { SimpleLorenz.new }

  context 'wheel 1 and 2 set to 0' do
    let(:wheel1) { 0 }
    let(:wheel2) { 0 }

    it "returns 'a' as 'a'" do
      message = 'a'
      machine.cipher(message).should == message
    end

    it "returns 'aa' as 'aa'" do
      message = 'aa'
      machine.cipher(message).should == message
    end

    it "returns 'aaa' as 'aaa'" do
      message = 'aaa'
      machine.cipher(message).should == message
    end

    it "returns 'aba' as 'abc'" do
      machine.cipher('aba').should == 'abc'
    end

    it "returns 'bbb' as 'bdd'" do
      machine.cipher('bbb').should == 'bdd'
    end
  end
end
