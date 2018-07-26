$(document).on('turbolinks:load', function() { 
  var input = $('.quantity-input');
  var quantity = parseInt(input.val())

  $('.quantity-minus').click(function(event){
    event.preventDefault()
    if (quantity > 1) {
      quantity -= 1
      input.val(quantity)
    }
  });

  $('.quantity-plus').click(function(event){
    event.preventDefault()
    quantity += 1
    input.val(quantity)
  });
});