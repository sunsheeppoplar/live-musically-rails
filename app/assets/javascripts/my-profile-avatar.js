function previewFile() {
	console.log("previewFile called");
	var preview = document.querySelector('#demo-basic');
	var file    = document.querySelector('#my_profile_form_avatar').files[0];
	var reader  = new FileReader();

	reader.addEventListener("load", function () {
		preview.src = reader.result;

		var basic = $('#demo-basic').croppie({
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
		basic.croppie('bind', {
			url: preview.src,
		});
		//on button click
		basic.croppie('result', 'html').then(function(html) {
			// html is div (overflow hidden)
			// with img positioned inside.
		});

	}, false);

	if (file) {
		reader.readAsDataURL(file);	
	}
}
