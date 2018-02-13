$(document).on('turbolinks:load', function(){
	function handleAuthClick(e) {
		var formSelected = e.target.dataset.authType;
		var loginClass = '.js-login';
		var signupPrimaryClass = '.js-signup-primary';
		var loginSwitchTextClass = '.auth-form-toggler > h3[data-auth-type="login"]';
		var signupSwitchTextClass = '.auth-form-toggler > h3[data-auth-type="signup"]';

		if (formSelected === 'login') {
			handleForms(loginClass, signupPrimaryClass);
			toggleSelectedText(loginSwitchTextClass, signupSwitchTextClass);
		}

		if (formSelected === 'signup') {
			handleForms(signupPrimaryClass, loginClass);
			toggleSelectedText(signupSwitchTextClass, loginSwitchTextClass);
		}
	}

	function toggleSelectedText(selected, deselected) {
		var selectIt = 'auth-form-toggler--selected';

		$(selected).addClass(selectIt);
		$(deselected).removeClass(selectIt);
	}

	function handleForms(toShow, toHide) {
		var signupSecondaryClass = '.js-signup-secondary';

		if (isVisible(toShow)) {
			return;
		}

		toggleForm(toShow, 'show');
		toggleForm(toHide, 'hide');
		toggleForm(signupSecondaryClass, 'hide');
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
			$(selector).addClass(hideIt).removeClass(showIt);
		}
	}
	
	function showProperSignupForm(userRole) {
		$('.auth-form__next-button').click(function(e) {
			var signupForm = '.js-signup-secondary';
			var userChoiceForm = '.js-signup-primary';
			var facebookSignupForm = '.js-signup-fb';

			toggleForm(signupForm, 'show');
			assignUserRoleToSignup(signupForm, userRole)
			assignUserRoleCallbackQueryString(facebookSignupForm, userRole);
			toggleForm(userChoiceForm, 'hide');
		})
	}

	function chooseUserRole(e) {
		var userRoleChosen = e.target.dataset.userRole;
		toggleUserRoleButtonSelected(userRoleChosen);
		showProperSignupForm(userRoleChosen);
	}

	function toggleUserRoleButtonSelected(userRole) {
		var selectIt = 'auth-form__user-roles-button--selected';
		var musicianButtonClass = '.auth-form__user-roles-button[data-user-role="musician"]'
		var employerButtonClass = '.auth-form__user-roles-button[data-user-role="artist_employer"]'

		if (userRole === 'musician') {
			$(musicianButtonClass).addClass(selectIt);
			$(employerButtonClass).removeClass(selectIt);
		}

		if (userRole === 'artist_employer') {
			$(employerButtonClass).addClass(selectIt);
			$(musicianButtonClass).removeClass(selectIt);
		}
	}

	function assignUserRoleCallbackQueryString(form, role) {
		var userRoleQueryString = "?user_role=" + role;
		var facebookAuthUrl = 'http://localhost:3000/users/auth/facebook';
		$(form).attr('href', '');
		$(form).attr('href', facebookAuthUrl.concat(userRoleQueryString));
	}

	function assignUserRoleToSignup(form, role) {
		var hiddenInput = '#user_role';

		$(form).find(hiddenInput)[0].value = role;
	}

	// assign event handlers
	$('.auth-form-toggler').click(handleAuthClick)
	$('.auth-form__user-roles-button').click(chooseUserRole)
})