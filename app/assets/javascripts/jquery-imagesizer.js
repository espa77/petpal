$('.card img').each(function() {

  var $current =  $(this),
      height = $current.height(),
      max_h = $('.img-contain').height();
  if (height > max_h) {
    $current.css({ 'height':'100%','width': 'auto'});
  }
});
