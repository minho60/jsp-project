(() => {
  const $sender_name = $("[name=sender_name]");
  const $sender_phone = $("[name=sender_phone]");
  const $receiver_name = $("[name=receiver_name]");
  const $receiver_postcode = $("[name=receiver_postcode]");
  const $receiver_address1 = $("[name=receiver_address1]");
  const $receiver_address2 = $("[name=receiver_address2]");
  const $receiver_phone = $("[name=receiver_phone]");

  let receiverInfoType = 1;

  /* prettier-ignore */
  function fillReceiver(name = "", postcode = "", address1 = "", address2 = "", phone = "") {
    $receiver_name.val(name);
    // $receiver_postcode.val(postcode);
    // $receiver_address1.val(address1);
    // $receiver_address2.val(address2);
    $receiver_phone.val(phone);
  }

  function fillReceiverBySender() {
    fillReceiver($sender_name.val(), null, null, null, $sender_phone.val());
  }

  function updateReceiver() {
    switch (receiverInfoType) {
      case 0:
        fillReceiver();
        $receiver_name.removeAttr("disabled");
        $receiver_phone.removeAttr("disabled");
        break;
      case 1:
        fillReceiverBySender();
        $receiver_name.attr("disabled", true);
        $receiver_phone.attr("disabled", true);
        break;
    }
  }

  $sender_name.add($sender_phone).on("input change", (e) => {
    if (receiverInfoType != 1) return;
    updateReceiver();
  });

  $("[name=delivery_info_type]").change((e) => {
    receiverInfoType = Number($(e.currentTarget).val());
    updateReceiver();
  });

  updateReceiver();

  const postCodeHandler = new daum.Postcode({
    oncomplete: function (data) {
      const { zonecode, address } = data;

      $receiver_postcode.val(zonecode);
      $receiver_address1.val(address);
      $receiver_address2.focus();
    },
  });

  $(".btn-postcode").click((e) => {
    e.preventDefault();
    postCodeHandler.open();
  });

  let popupWindow = null;

  $("form.order-wrapper").submit((e) => {
    e.preventDefault();

    const form = e.currentTarget;
    const formData = new FormData(form);
    const dataObj = Object.fromEntries(formData.entries());

    popupWindow = window.open(
      "payment_popup",
      "payment_popup",
      "toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=500,height=710"
    );

    popupWindow.onload = () => {
      popupWindow.receiveData(dataObj);
    };
  });
})();
