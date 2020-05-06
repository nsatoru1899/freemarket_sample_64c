$(document).on('turbolinks:load', ()=> { 
  fixURL();
  layoutImg();

  function fixURL(){
  var currentUrl = location.href
  if(currentUrl=='http://localhost:3000/items' || currentUrl=='http://54.199.158.8/items'){
  history.pushState('', '', location.href + '/new')
  }};


  // ファイルフィールドと画像プレビューのレイアウトを整える関数
  function layoutImg(){
  if($('.image-input').length >= 2){
    $('.form-image').css({'display':'flex', 'justify-content':'space-between', 'align-items':'center'});    
    $('.image-description').css('display','none');
    $('.first-image').css('display', 'inline');
    $('#drop-area > label').css('margin-top', '0');
    }
  };
  
  // 画像用のinputを生成する関数
  var buildFileField = (index)=> {
    var html = `<div data-index="${index}" class="file-field-group">
                    <input class="image-input" type="file"
                    name="item[images_attributes][${index}][src]"
                    id="item_images_attributes_${index}_src">
                    <span class="remove-image empty-remove remove-${index}">削除</span>
                  </div>`;
    return html;
  }

  var buildImg = (index, url)=> {
    var html = `<img data-index="${index}" src="${url}" width="70px" height="70px" class="image-preview">`;
    return html;
  }

  // file_fieldのnameに動的なindexをつける為の配列
  var fileIndex = [1,2,3,4,5,6,7,8,9,10];
  
  // 繰り返し使われる記述を変数に代入
  var defaultImg = $('.image-default');
  var attachedImg = $('.image-input');

  // 既に使われているindexを除外
  lastIndex = $('.file-field-group:last').data('index');
  fileIndex.splice(0, lastIndex);
  $('.hidden-destroy').hide();
  defaultImg.hide();
  defaultImg.prop('disabled',true);

  // ファイルフィールドが変更された際の処理
  $('#drop-area').on('change', '.image-input', function(e) {
    var targetIndex = $(this).parent().data('index');
        // ファイルのブラウザ上でのURLを取得する
    var file = e.target.files[0];
    var blobUrl = window.URL.createObjectURL(file);
    // 該当indexを持つimgタグがあれば取得して変数imgに入れる(画像変更の処理)
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {  // 新規画像追加の処理
      $('#previews').append(buildImg(targetIndex, blobUrl));
      // fileIndexの先頭の数字を使ってinputを作る
      $('#drop-area').append(buildFileField(fileIndex[0]));
      fileIndex.shift();
      // 末尾の数に1足した数を追加する
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
      // css追加
      attachedImg.css('width', '200px');
      layoutImg();
      if(attachedImg.length >= 1){
      // ファイルが登録されたファイルフィールドの横に削除ボタンを設置
      $(".remove-first").removeClass('empty-remove');
      $(".remove-"+targetIndex).removeClass('empty-remove');
      };

      // 画像を10枚以上登録しようとするとアラートを出す処理
      if(attachedImg.length > 10){
        window.alert('アップロードできる画像は10枚までです。')
      }
    }
  });

  // 削除ボタンが押された際の処理
  $('#drop-area').on('click', '.remove-image', function() {
    $(this).parent().remove();
    var targetIndex = $(this).parent().data('index');
        // 該当indexを振られているチェックボックスを取得する
    var hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
        // もしチェックボックスが存在すればチェックを入れる
    if (hiddenCheck) hiddenCheck.prop('checked', true);
    $(`img[data-index="${targetIndex}"]`).remove();
    // 画像入力欄が0個にならないようにしておく
    if (attachedImg.length == 0) $('#drop-area').append(buildFileField(fileIndex[0]));
  });

  // 商品説明フォームの文字数カウント
  $(".detail-input").on("keyup change",function(){
      var text_length = $(this).val().length;
      $(".text-count").text(text_length + "/1000");
      if(text_length > 1000){window.alert("1000文字以内で入力してください")}
    })
  
  // 親カテゴリーを選択したら子カテゴリーが表示される（子カテゴリーを選択したら孫カテゴリーが表示される）
  // カテゴリー機能実装前のためデータはダミー
  
 
  // 販売手数料、販売利益の計算
  $(".price-input").on("change",function(){
    var price = Number($(".price-input").val()); // 販売価格 
    if(price < 300){window.alert("¥300以上の金額を指定してください")}
    else if(price > 9999999){window.alert("¥999,999,999以下の金額を指定してください")}
    else{
      var commission = Math.round(price * 0.1); // 販売手数料
      var profit = price - commission; // 販売利益
        $(".commission-value").text("¥"+commission.toLocaleString());
        $(".profit-value").text("¥"+profit.toLocaleString());
      };
    })
});
