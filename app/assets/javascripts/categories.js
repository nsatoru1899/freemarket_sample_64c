$(document).on('turbolinks:load', ()=> { 

  // #item_category_idはバリデーションのため設置。入力不要なのでhideしておく
    $('#item_category_id option').remove()
    $('#item_category_id').hide()
  
    function appendOption(category) {
      var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
      return html;
    }
  
    function appendChildrenBox(insertHTML) {
      var childSelectHtml = '';
      childSelectHtml = `
                         <div class='select--wrap' id= 'category__box--children'>
                           <select class="select--wrap-cat1__default-category1" id="child_form" name="category_id">
                             ${insertHTML}
                           </collection_celect>
                         </div>
                        `;
      $('.item-detail__category').append(childSelectHtml);
    }
  
    function appendGrandchildrenBox(insertHTML) {
      var grandchildSelectHtml = '';
      grandchildSelectHtml = `
                              <div class='select--wrap' id= 'category__box--grandchildren'>
                                <select class="select--wrap-cat1__default-category1" id="grandchild_form" name="item[category_id]">
                                  ${insertHTML}
                                </select>
                              </div>
                             `;
      $('.item-detail__category').append(grandchildSelectHtml);
    }
  
    $("#item_category").on("change", function() {
      var parentValue = $("#item_category").val();
      var selectedParentValue = $('.selected_parent_category').val();
      if (parentValue != "" || parentValue != selectedParentValue ) { 
        $.ajax({
          url     : 'category_children',
          type    : 'GET',
          data    : {
            parent_id: parentValue
          },
          dataType: 'json'
        })
  
        .done(function(children) {
          $('#category__box--children').remove();
          $('#category__box--grandchildren').remove();
          var insertHTML = '';
          children.forEach(function(child){
            insertHTML += appendOption(child);
          });
          appendChildrenBox(insertHTML);
        })
        .fail(function() {
          alert('カテゴリーを入力して下さい');
        })
      } else {
        $('#category__box--children').remove();
        $('#category__box--grandchildren').remove();
      }
    });
  
    $(".item-detail__category").on("change", "#child_form", function() {
      // $('#category__box--grandchildren').remove();
      var childValue = $("#child_form").val();
      var selectedChildrenValue = $('.selected_children_category').val();
      if (childValue != "" || childValue != selectedChildrenValue) {
        $.ajax({
          url     : 'category_grandchildren',
          type    : 'GET',
          data    : {
            child_id: childValue
          },
          dataType: 'json'
        })
  
        .done(function(grandchildren) {
          $('#category__box--grandchildren').remove();
          var insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendOption(grandchild);
          });
          appendGrandchildrenBox(insertHTML);
        })
        .fail(function() {
          alert('カテゴリーを入力して下さい');
        })
      } else {
        $('#category__box--grandchildren').remove();
      }
    });
  
    // 送信時に孫フィールドまで存在すればバリデーション用のフィールドを削除
    $(".actions").on("click", ".actions__submit", function() {
      if ($('#category__box--grandchildren').size()){
        $('#for_validate').remove();
      } 
    })

    $("#item_forms").submit(function(){
      if(!$('#category__box--grandchildren').size()){
        alert("カテゴリーは孫まで選択してください");
        var scroll_point = $('#scroll_point').offset().top
        $(window).scrollTop(scroll_point);
        return false;
      }
    })
  });