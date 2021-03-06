class Cart < ApplicationRecord
  belongs_to :user
  has_many   :cart_products, dependent: :destroy
  has_many   :products, through: :cart_products

  def cart_informations(cart)
    cart.cart_products
  end

  def cart_price_sum(cart)
    sum = 0
    cart_informations(cart).each do |cart_information|
      sum  += cart_information.product.price * cart_information.product_count
    end
    return sum.floor.to_s(:delimited)
  end


  def cart_count_sum(cart)
    sum = 0
    cart_informations(cart).each do |cart_count|
      sum  += cart_count.product_count
    end
    return sum.floor.to_s(:delimited)
  end

  def cart_point_sum(cart)
    sum = 0
    cart_informations(cart).each do |cart_information|
      sum  += cart_information.product.price * cart_information.product_count
    end
    return (sum / 10).floor.to_s(:delimited)

  end

end
