$('.card img').each(function() {

  var $current =  $(this),
      height = $current.height(),
      max_h = $('.img-contain').height();
      debugger
  if (height > max_h) {
    $current.css({ 'height':'50px','width': 'auto'});
  }
});
