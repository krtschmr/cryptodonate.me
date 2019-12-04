// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// require("@rails/ujs").start()
// require("@rails/activestorage").start()
// require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
// Support component names relative to this directory:
// var componentRequireContext = require.context("components", true);
// var ReactRailsUJS = require("react_ujs");
// ReactRailsUJS.useContext(componentRequireContext);

let hideActivePaymentInformation = () => {
  let active = document.querySelector("#payment-info .payment-address.block");
  if(active !== null) {
    active.classList.remove("block");
  }
}

let hidePaymentSelection = () =>  {
  document.querySelector("#select-payment-method").classList.remove("block");
}

let showPaymentSelection = () =>  {
  document.querySelector("#select-payment-method").classList.add("block");
}

let showReturnButton = () => {
  document.querySelector("#abort-button").classList.remove("block");
  document.querySelector("#return-button").classList.add("block");
}

let showAbortButton = () => {
  document.querySelector("#abort-button").classList.add("block");
  document.querySelector("#return-button").classList.remove("block");
}

let returnButtonClick = () => {
  console.log("return button clicked");
  showAbortButton();
  showPaymentSelection();
  hideActivePaymentInformation();
}

let paymentMethodClick = (element, event) => {
  event.preventDefault();
	console.log(element);
  console.log(event);

  let coin = element.getAttribute("data-coin");

  hideActivePaymentInformation();

  let container = document.querySelector(`#payment-info .payment-address.${coin.toLowerCase()}`);
  container.classList.add('block');

  hidePaymentSelection();
  showReturnButton();
}


document.addEventListener('click', function (event) {

  if (event.target.matches('#return-button .back-icon')) {
    returnButtonClick();
  }

  // If the clicked element doesn't have the right selector, bail
  if (event.target.matches('#select-payment-method .method')) {
    paymentMethodClick(event.target, event)
  }
  if( event.target.matches('#select-payment-method .method img') || event.target.matches('#select-payment-method .method span') ) {
    paymentMethodClick(event.target.parentElement, event)
  }

}, false);
