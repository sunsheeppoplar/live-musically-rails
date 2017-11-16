$(function(){
	function handleAuthClick(e) {
		var formSelected = e.target.dataset.authType;
		var loginClass = '.js-login';
		var signupClass = '.js-signup-primary';

		if (formSelected === 'login') {
			handleForms(loginClass, signupClass, toggleForm('.js-signup-secondary', 'hide'));
		}

		if (formSelected === 'signup') {
			handleForms(signupClass, loginClass);
		}
	}

	function handleForms(toShow, toHide, callback) {
		if (isVisible(toShow)) {
			return;
		}

		toggleForm(toShow, 'show');
		toggleForm(toHide, 'hide');

		if (callback) {
			callback();
		}
	}

	function isVisible(form) {
		return $(form)[0].classList.contains('.auth-form--visible');
	}

	function toggleForm(selector, visibility) {
		var showIt = 'auth-form--visible';
		var hideIt = 'auth-form--hidden';

		if (visibility === 'show') {
			$(selector).addClass(showIt).removeClass(hideIt);
		}

		if (visibility === 'hide') {
			$(selector).addClass(hideIt).removeClass(showIt)
		}
	}
	
	function showProperSignupForm(userRole) {
		$('.auth-form__next-button').click(function(e) {
			var signupForm = '.js-signup-secondary';
			var userChoiceForm = '.js-signup-primary';
			var hiddenInput = '#user_role';
			var userRoleChosen = userRole;

			toggleForm(signupForm, 'show');
			$(signupForm).find(hiddenInput)[0].value = userRoleChosen;
			toggleForm(userChoiceForm, 'hide');
		})
	}

	function chooseUserRole(e) {
		var userRoleChosen = e.target.dataset.userRole;
		showProperSignupForm(userRoleChosen);
	}

	// assign event handlers
	$('.auth-form-toggler').click(handleAuthClick)

	$('.auth-form__user-role').click(chooseUserRole)
})