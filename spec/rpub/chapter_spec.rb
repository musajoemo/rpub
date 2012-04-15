require 'spec_helper'

describe RPub::Chapter do
  let(:subject) { described_class.new('foo', 1, 'document') }

  its(:content) { should == 'foo' }
  its(:number)  { should == 1 }
  its(:layout)  { should == 'document' }

  describe '#uid' do
    it 'should change when content changes' do
      subject.uid.should_not == described_class.new('bar', 1, 'bar').uid
    end

    it 'should change when layout changes' do
      subject.uid.should_not == described_class.new('foo', 1, 'qux').uid
    end

    it 'should change when content changes' do
      subject.uid.should_not == described_class.new('foo', 2, 'bar').uid
    end
  end

  describe '#id' do
    its(:id) { should == 'chapter-1' }
  end

  describe '#filename' do
    its(:filename) { should == 'chapter-1-untitled.html' }
  end

  describe '#title' do
    context 'without a suitable markdown title' do
      its(:title) { should == 'untitled' }
    end

    context 'with a markdown heading' do
      let(:subject) { described_class.new('# My Title', 1, 'bar') }
      its(:title) { should == 'My Title' }
    end
  end

  describe 'markdown parsing' do
    let(:subject) { described_class.new('foo', 1, nil) }
    its(:to_html) { should == "<p>foo</p>\n" }
  end
end
