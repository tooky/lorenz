require 'spec_helper'

describe 'a three wheel encryption mechanism' do
  let(:machine) { SimpleLorenz.new(wheel1, wheel2) }

  let(:character_set) { [
    "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p",
    "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", ".", ",", "?", "!", " "
  ] }

  before do
    SimpleLorenz[character_set, 2, 2]
  end

  context 'wheel 1 and 2 set to 0' do
    let(:wheel1) { 0 }
    let(:wheel2) { 0 }

    context 'when encoding' do
      it "returns 'a' as 'a'" do
        machine.encrypt('a').should == 'a'
      end

      it "returns 'aa' as 'aa'" do
        machine.encrypt('aa').should == 'aa'
      end

      it "returns 'aaa' as 'aaa'" do
        machine.encrypt('aaa').should == 'aaa'
      end

      it "returns 'aba' as 'abc'" do
        machine.encrypt('aba').should == 'abc'
      end

      it "returns 'bbb' as 'bdd'" do
        machine.encrypt('bbb').should == 'bdd'
      end

      it "returns 'hello, world!' as 'hstcfywu,ooze'" do
        machine.encrypt('hello, world!').should == 'hstcfywu,ooze'
      end
    end

    context 'when decoding' do
      it "returns 'a' as 'a'" do
        machine.decrypt('a').should == 'a'
      end

      it "returns 'aa' as 'aa'" do
        machine.decrypt('aa').should == 'aa'
      end

      it "returns 'aaa' as 'aaa'" do
        machine.decrypt('aaa').should == 'aaa'
      end

      it "returns 'abc' as " do'aba'
        machine.decrypt('abc').should == 'aba'
      end

      it "returns 'bdd' as " do'bbb'
        machine.decrypt('bdd').should == 'bbb'
      end

      it "returns 'hstcfywu,ooze' as " do'hello, world!'
        machine.decrypt('hstcfywu,ooze').should == 'hello, world!'
      end
    end
  end

  context "wheel 1 set to '1' and wheel 2 set to '0'" do
    let(:wheel1) { 1 }
    let(:wheel2) { 0 }

    context 'when encoding' do
      it "returns 'a' as 'b'" do
        machine.encrypt('a').should == 'b'
      end

      it "returns 'aa' as 'bb'" do
        machine.encrypt('aa').should == 'bb'
      end

      it "returns 'aaa' as 'bbb'" do
        machine.encrypt('aaa').should == 'bbb'
      end

      it "returns 'aba' as 'bcd'" do
        machine.encrypt('aba').should == 'bcd'
      end

      it "returns 'bbb' as 'cee'" do
        machine.encrypt('bbb').should == 'cee'
      end

      it "returns 'hello, world!' as 'itudgzxv?pp.f'" do
        machine.encrypt('hello, world!').should == 'itudgzxv?pp.f'
      end
    end

    context 'when decoding' do
      it "returns 'b' as 'a'" do
        machine.decrypt('b').should == 'a'
      end

      it "returns 'bb' as 'aa'" do
        machine.decrypt('bb').should == 'aa'
      end

      it "returns 'bbb' as 'aaa'" do
        machine.decrypt('bbb').should == 'aaa'
      end

      it "returns 'bcd' as 'aba'" do
        machine.decrypt('bcd').should == 'aba'
      end

      it "returns 'cee' as 'bbb'" do
        machine.decrypt('cee').should == 'bbb'
      end

      it "returns 'itudgzxv?pp.f' as 'hello, world!'" do
        machine.decrypt('itudgzxv?pp.f').should == 'hello, world!'
      end
    end
  end

  context "wheel 1 set to '1' and wheel 2 set to '3'" do
    let(:wheel1) { 1 }
    let(:wheel2) { 3 }

    context 'when encoding' do
      it "returns 'a' as '.'" do
        machine.encrypt('a').should == '.'
      end

      it "returns 'aa' as '..'" do
        machine.encrypt('aa').should == '..'
      end

      it "returns 'aaa' as '...'" do
        machine.encrypt('aaa').should == '...'
      end

      it "returns 'aba' as 'bcd'" do
        machine.encrypt('aba').should == '.,?'
      end

      it "returns 'bbb' as 'cee'" do
        machine.encrypt('bbb').should == ',!!'
      end

      it "returns 'hello, world!' as 'cno?atrpwjju '" do
        machine.encrypt('hello, world!').should == 'cno?atrpwjju '
      end
    end

    context 'when decoding' do
      it "returns '.' as 'a'" do
        machine.decrypt('.').should == 'a'
      end

      it "returns '..' as 'aa'" do
        machine.decrypt('..').should == 'aa'
      end

      it "returns '...' as 'aaa'" do
        machine.decrypt('...').should == 'aaa'
      end

      it "returns 'bcd' as 'aba'" do
        machine.decrypt('.,?').should == 'aba'
      end

      it "returns 'cee' as 'bbb'" do
        machine.decrypt(',!!').should == 'bbb'
      end

      it "returns 'cno?atrpwjju ' as 'hello, world!'" do
        machine.decrypt('cno?atrpwjju ').should == 'hello, world!'
      end
    end
  end

  context 'full character set with wheels set to 6,5' do
    let(:wheel1) { 6 }
    let(:wheel2) { 5 }

    let(:character_set) { [
      "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
      "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
      "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
      "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
      "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
      ".", ",", "?", "!", "'", "\"", " "
    ] }

    it "ciphers and deciphers a long message" do
      message = "Mary Had a little lamb who's fleece was white as snow!"
      cipher = %{I7qOkB'c4U"f!1NFz6fvly0qH,OiYZuzljh6qArYqHv186UrYmF6Gd}
      machine.encrypt(message).should == cipher
      machine.decrypt(cipher).should == message
    end
  end
end
