$(document).on('turbolinks:load', function() {


	$('.js-open-decision-modal').on('click', function() {
		var decision = this.dataset.decision;
		var id = this.dataset.id;
		var modalClass = '.js-decision-modal-' + id;

		$(modalClass).show().find('span').html(decision)
	})
})