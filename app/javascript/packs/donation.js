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



import consumer from "./consumer"
let timer = undefined;

const uuid = document.querySelector('body').dataset.uuid;
let channel = undefined;
if(uuid !== undefined ){
  channel = consumer.subscriptions.create({channel: "DonationChannel", uuid: uuid}, {
    connected(){
      console.log(`connected to donation ${uuid}`);
    },
    received(data) {
      if(data.template !== null) {
        clearInterval(timer);
        document.querySelector("#donation-box .body").innerHTML = data.template;
      }
      if(data.state == "paid" || data.state == "expired") {
        this.unsubscribe();
        this.consumer.disconnect();
      }
    }
  });
}




Number.prototype.pad = function(size) {
    var s = String(this);
    while (s.length < (size || 2)) {s = "0" + s;}
    return s;
}

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
  hideAllQrCodes();
  hideActivePaymentInformation();
  showPaymentSelection();
}

let paymentMethodClick = (element, event) => {
  event.preventDefault();
	console.log(element);
  console.log(event);

  let coin = element.getAttribute("data-coin");

  hideActivePaymentInformation();

  let container = document.querySelector(`#payment-info .payment-address.${coin.toLowerCase()}`);
  container.classList.add('block');

  let hiddenButton = document.querySelector("button.show-qr-code.btn.d-none")
  if(hiddenButton !== null){
    hiddenButton.classList.remove("d-none")
  }

  hidePaymentSelection();
  showReturnButton();
}

let showQrCode = (element, event) => {
  console.log(element);
  console.log(event);
  let coin = element.getAttribute("data-coin");
  let qr = document.querySelector(`.qr-code.${coin.toLowerCase()}`);
  qr.classList.remove("d-none")
}

let hideAllQrCodes = () => {
  document.querySelectorAll(".qr-code").forEach(qr => qr.classList.add("d-none") );
}



let initTimer = () => {
  let paymentInfo = document.querySelector("#payment-info")
  if(paymentInfo === null) { return }

  let secondsLeft = paymentInfo.getAttribute("data-seconds-left")

  timer = window.setInterval(function(){
    secondsLeft = secondsLeft - 1;
    const seconds = secondsLeft % 60;
    const minute = parseInt((secondsLeft - seconds) / 60)

    document.querySelector("span.time-left").innerText = `${minute}:${seconds.pad()}`
  }, 1000);
}


function ready(fn) {
  if (document.readyState != 'loading'){
    fn();
  } else {
    document.addEventListener('DOMContentLoaded', fn);
  }
}

ready(function() {
  initTimer();
})



document.addEventListener('click', function (event) {

  if (event.target.matches('.back-button')) {
    returnButtonClick();
  }

  // If the clicked element doesn't have the right selector, bail
  if (event.target.matches('#select-payment-method .method')) {
    paymentMethodClick(event.target, event)
  }
  if( event.target.matches('#select-payment-method .method img') || event.target.matches('#select-payment-method .method span') ) {
    paymentMethodClick(event.target.parentElement, event)
  }

  if (event.target.matches('button.show-qr-code')) {
    event.target.classList.add("d-none");
    showQrCode(event.target, event)

  }

}, false);
