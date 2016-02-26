json.order do
  json.id                       @order.id
  json.user_id	                @order.user_id
  json.status                 	@order.status
  json.created_at               @order.created_at
  json.updated_at               @order.updated_at
  json.amount_cents            	@order.amount_cents
  json.payment              	@order.payment
  json.quantity               	@order.quantity
  json.meal_id             		@order.meal_id
end

 
  

   
 