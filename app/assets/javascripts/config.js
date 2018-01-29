$(document).on('turbolinks:load', function() {
	function setJSONDefault() {
		$.ajaxSetup({
  			dataType: 'json'
		})
	}

	setJSONDefault();
})