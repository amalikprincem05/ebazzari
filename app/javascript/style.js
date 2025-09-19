let authContainer = document.getElementById('auth-container');

function authToggle() {
	authContainer.classList.toggle('auth-sign-in');
	authContainer.classList.toggle('auth-sign-up');
}

setTimeout(() => {
	authContainer.classList.add('auth-sign-in');
}, 200);
