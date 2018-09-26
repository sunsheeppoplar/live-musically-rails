var basic;

function openModal() {
	var uniquename = document.querySelector(".cropper-modal");
	var closeButton = document.querySelector(".close-button");
	uniquename.classList.toggle("show-modal");
	closeButton.addEventListener("click", closeModal);
	closeButton.addEventListener("click", function() { basic.destroy(); });
}

function closeModal() {
	var uniquename = document.querySelector(".cropper-modal");
	uniquename.classList.toggle("show-modal");
}

function previewFile() {
	console.log("previewFile called");
	openModal();
	var preview = document.querySelector('#demo-basic');
	var file    = document.querySelector('#my_profile_form_avatar').files[0];
	var reader  = new FileReader();

	reader.addEventListener("load", function () {
		preview.src = reader.result;

		el = document.getElementById('demo-basic');
		btn = document.getElementById('demo-basic-button');
		form = document.getElementById('new-my-profile-form');

		basic = new Croppie(el, {
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
				
				var avatar = document.querySelector('.js-avatar')
				avatar.src = crop;
				avatar.setAttribute("style","height:250px; width:250px;");

				closeModal();
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
