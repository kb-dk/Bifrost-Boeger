require 'spec_helper'

describe 'Create e-book' do


  before(:all) do
    @message = File.read("#{Rails.root}/spec/fixtures/valhal_message.json")
  end

  before(:each) do
    @service = EBookCreationService.new
  end

  it 'should Create an e-book' do
    book = @service.create_from_message(@message)
    book.should be_a EBook
    EBook.find(book.pid).should be_a EBook
    book.uuid.should eql "444cd730-3f15-0131-5772-0050562881f4"
    book.url.should be_a Array
    book.url.include?("http://www.kb.dk/e-mat/dod/130020709562.pdf").should be_true
  end

end