$(document).on('turbolinks:load', function() {
	var cachedDom = {
		$headerAvatar: $('.js-header-avatar'),
		$headerDropDownMenu: $('.js-header-avatar-dropdown-menu')
	};

	function showHeaderDropdownMenu() {
		cachedDom.$headerDropDownMenu.toggleClass('header__avatar__dropdown--hidden')
	}

	cachedDom.$headerAvatar.on('click', showHeaderDropdownMenu)
})