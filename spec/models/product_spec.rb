require 'spec_helper'

describe Product do
  before(:each) do
    @attr = {:title => "My Book Title", :description => "My Book Description", :image_url => "book.jpg", :price => 2.0}
  end

  it "should not a create a new instance if the attributes are empty" do
    product = Product.new
    product.should_not be_valid
    product.errors[:title].should_not be_empty
    product.errors[:description].should_not be_empty
    product.errors[:price].should_not be_empty
    product.errors[:image_url].should_not be_empty
  end

  it "should not create a product with negative price" do
    product = Product.new(@attr.merge(:price => -1))
    product.should_not be_valid
    product.errors[:price].join('; ').should == "must be greater than or equal to 0.01"
  end

  it "should not create a product with price equal to 0" do
    product = Product.new(@attr.merge(:price => 0))
    product.should_not be_valid
    product.errors[:price].join('; ').should == "must be greater than or equal to 0.01"
    end

  it "should create a product with price greater than 0" do
    product = Product.new(@attr.merge(:price => 2))
    product.should be_valid
  end

  it "should not create a product without valid image url" do
    image_urls = %w[test.doc test.gif.more]
    image_urls.each do |image_url|
      product = Product.new(@attr.merge(:image_url => image_url))
      product.should_not be_valid
    end
  end

  it "should not create a product with valid image url" do
    image_urls = %w[test.gif test.jpg]
    image_urls.each do |image_url|
      product = Product.new(@attr.merge(:image_url => image_url))
      product.should be_valid
    end
  end

  it "should not create a product without a unique title" do
    product = Product.create!(@attr)
    product = Product.new(@attr.merge(:title => "My Book Title"))
    product.should_not be_valid
    product.errors[:title].join('; ').should == I18n.translate('activerecord.errors.messages.taken')
  end
end
