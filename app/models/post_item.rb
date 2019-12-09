class PostItem
  include ActiveModel::Model 
  include ActiveModel::Validations 
  attr_accessor :quantity , :product_id
  validates :product_id, :quantity, presence:true, numericality: { only_integer: true, greater_than: 0 } 

  def create_items
    quantity.to_i.times{
        product.items.create!()
      }
  end

  def product
    Product.find(product_id)
  end
  
end

