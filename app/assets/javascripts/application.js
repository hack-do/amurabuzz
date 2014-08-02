// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require_tree.


function initialize(){

	//$('#main_body').hide();
	$('#spinner').hide();

	if(!$.fn.DataTable.fnIsDataTable($('#all_users_datatable')))
	{
		$('#all_users_datatable').dataTable({
		  	"sPaginationType": "bootstrap",
		   	// "processing": true,
    		// "serverSide": true,
    		// "ajax": $('#all_users_datatable').data('source'),
    		// "pagingType": 'full_numbers'
		});
	}


	//$.fn.dataTable.ext.errMode = 'throw';

	 $('#post_tweet').attr('disabled','disabled');	

	 $('#tweet_msg').keydown(function(e){
	 	var msg_len = $(this).val().length;
	 	$('#tweet_len').text(160 - msg_len);
	 	if ( msg_len > 0)
	 	{
	 			$('#post_tweet').removeAttr('disabled');
	 	}
	 	else
	 	{
	 		$('#post_tweet').attr('disabled','disabled');	
	 	}
	 });
	
	//-----------add ACTIVE class to navbar li
	$("#"+ $('body').data("cc") + "_" + $('body').data("ca")).parent().addClass("active");
};


$(document).ready(function() {	
	console.log("Page Reloaded(Ready Event JS)");
	//initialize();
});

$(document).on('page:change', function() {
  initialize();
});

// $(document).on('page:load', function() {
//   console.log("Page load Turbolinks");
// });



$(document).on('page:fetch', function() {

  //console.log("Page Fetch Turbolinks");
  $('#main_body').css("opacity","0.3");
  $('#main_body').css("z-index","-5");
  $('#spinner').css("z-index","10");
  $('#spinner').show();
});

$(document).on('page:receive', function() {

  //console.log("Page receive Turbolinks");
   $('#main_body').css("opacity","1");
   $('#main_body').css("z-index","10");
   $('#spinner').css("z-index","-5");
   $('#spinner').hide();
});

// $(document).on('page:update', function() {
//   console.log("Page update Turbolinks");
// });
// $(document).on('page:before-change', function() {
//   console.log("Page before change Turbolinks");
// });


function isDataTable ( nTable )
{
    var settings = $.fn.dataTableSettings;
    for ( var i=0, iLen=settings.length ; i<iLen ; i++ )
    {
        if ( settings[i].nTable == nTable )
        {
            return true;
        }
    }
    return false;
}


