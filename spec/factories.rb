Factory.define :product do |product|
  product.title "Lorem Ipsum"
  product.description "Testing the book"
  product.image_url "lorem.jpg"
  product.price 10.25
end

Factory.define :order do |order|
  order.name "John Doe"
  order.address "Some Address"
  order.email "email@email.com"
  order.pay_type "Credit card"
end