$(document).on('page:change', function() {
	$('#activity_tabs a').click(function (e) {
	  e.preventDefault()
	  $(this).tab('show')
	});
});