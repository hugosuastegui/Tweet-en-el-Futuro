$(document).ready(function() {
	// Este código corre después de que `document` fue cargado(loaded) 
	// completamente. 
	// Esto garantiza que si amarramos(bind) una función a un elemento 
	// de HTML este exista ya en la página.
  $('#submit_tweet_content').click(function(event){
    event.preventDefault();
    var tweet_content2 = $('#input').val();
    console.log(tweet_content2);
   $.post("/tweet", {tweet_content2: tweet_content2}, function(data){
    console.log("**************")
    console.log(data);
    $('#content_changer').html(data);
   }); 
  });
});


