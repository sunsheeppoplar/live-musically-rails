function previewFile() {
	console.log("previewFile called");
	var preview = document.querySelector('#demo-basic');
	var file    = document.querySelector('#my_profile_form_avatar').files[0];
	var reader  = new FileReader();

	reader.addEventListener("load", function () {
		preview.src = reader.result;

		el = document.getElementById('demo-basic');
		btn = document.getElementById('demo-basic-button');
		form = document.getElementById('new-my-profile-form');

		var basic = new Croppie(el, {
			viewport: {
				width: 100,
				height: 100,
				type: 'circle'
			},
			boundary: {
				width: 200,
				height: 200
			}
		});
		basic.bind({
			url: preview.src,
		});
		//on button click
		btn.addEventListener('click', function(event) {
			event.preventDefault();
			basic.result( 
				{
					type: 'base64',
					size: 'original'
				}
			).then(function(crop) {

				document.querySelector('#my_profile_form_cropped_avatar').value = crop;
				
				let avatar = document.querySelector('.js-avatar')
				avatar.src = crop;
				avatar.setAttribute("style","height:250px; width:250px;");

				basic.destroy();
				// html is div (overflow hidden)
				// with img positioned inside.
			});
		});

	}, false);

	if (file) {
		reader.readAsDataURL(file);
	}

}
