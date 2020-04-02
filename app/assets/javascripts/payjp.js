// DOM読み込みが完了したら実行
document.addEventListener('DOMContentLoaded', (e) => {
  // payjp.jsの初期化
  Payjp.setPublicKey('pk_test_5368ce76b1e8ded509d2a439');
  
  // ボタンのイベントハンドリング
  let btn = document.getElementById('token_submit');
  btn.addEventListener('click', (e) => {
    e.preventDefault();
    
    // カード情報生成
    let card = {
      number: document.getElementById('card_number').value,
      // brand: document.getElementById('card_company').value,
      cvc: document.getElementById('cvc').value,
      exp_month: document.getElementById('exp_month').value,
      exp_year: document.getElementById('exp_year').value
    };
    console.log(card);
    
    // トークン生成
    Payjp.createToken(card, (status, response) => {
      if (status === 200) { 
        $("#card_number").removeAttr("name");
        // $("#card_company").removeAttr("name");
        $("#cvc").removeAttr("name");
        $("#exp_month").removeAttr("name");
        $("#exp_year").removeAttr("name"); 
        $("#card_token").append(
          $('<input type="hidden" name="payjp-token">').val(response.id)
        ); 
        document.inputForm.submit();
        alert("登録が完了しました"); 
      } else {
        alert("カード情報が正しくありません。");
      }
    });
  });
}, false);