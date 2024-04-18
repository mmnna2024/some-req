const nameValidate = (name) => {
    if(!name) {
      return { message: '名前は入力必須項目です。' };
    }
    return { message: ''};
  }
  
  const phonenumberValidate = (phonenumber) => {
    if(!phonenumber) {
      return { message: '電話番号は入力必須項目です。'};
    }
    if(!phonenumber.match(/[0-9]+/g)) {
      return { message: '電話番号は数字で入力してください。'};
    }
    return { message: '' };
  }
  
  const addressValidate = (address) => {
    if(!address) {
      return { message: '住所は入力必須項目です。'};
    }
    return { message: ''};
  }
  
  // NOTE: categoryまでアクセスするため注意
  const selectedValidate = (selected) => {
    let message = '';
    selected.forEach((select) => {
      if (select.category && select.category.id !== undefined && Number.isNaN(select.category.id)) {
        message = '衣類の選択をしてください。'; // エラーメッセージを設定
      }
    });
   return { message }; // 結果を返す
  }
  
  const shippingValidate = (shippingId) => {
    if (Number.isNaN(shippingId)) {
      return { message: '送付先の選択をしてください。' };
    }
    return { message: '' };
  }

  const chanelValidate = (chanel) => {
    if(!chanel) {
      return { message: '受付は入力必須項目です。' };
    }
    return { message: ''};
  }
  
  // @params msg: { name: '', phonenumber: '', address: '', selected: '', shipping: '' }
  const crearValidation = (msg) => {
    return Object.values(msg).every(value => value === '');
  }
  
  export {
    nameValidate,
    phonenumberValidate,
    addressValidate,
    selectedValidate,
    shippingValidate,
    chanelValidate,
    crearValidation
  };