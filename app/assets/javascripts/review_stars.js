$(document).on('turbolinks:load', function () {
    // スターつける処理・レビュー送信処理の両方で使う変数
    var sendFlag = false;

    // ここからスターつける処理
    var fixedStarValue = $("#fixed_star_rate").attr("value");

    function clearStarClass() {
        $(".bigStar").removeClass("blueStar");
        $(".bigStar").removeClass("yellowStar");
    }

    function appendYellowStarClass() {
        var targets = $(".bigStar");

        targets.each(function(i, ele) {
            var target_star_val = $(ele).data("star-value");
            if(fixedStarValue >= target_star_val){
                $(ele).addClass("yellowStar");
            }
        });
    }

    function clearHowIsThisProduct() {
        $("#how_is_this_product").text("");
    }

    function clearUserInfoArea() {
        $("#user_info_area").css("display", "none");
    }

    function resetUserInfoArea() {
        $("#user_info_area").css("display", "block");
    }

    $(".bigStar").on("mouseenter", function() {
        if (!sendFlag) {
            var this_star_val = $(this).data("star-value");
            var targets = $(".bigStar");

            clearStarClass();
            clearUserInfoArea();

            switch (this_star_val) {
                case 2 :
                    $("#how_is_this_product").text("ん～…まあ…");
                    break;
                case 4 :
                    $("#how_is_this_product").text("悪くはない");
                    break;
                case 6 :
                    $("#how_is_this_product").text("普通");
                    break;
                case 8 :
                    $("#how_is_this_product").text("なかなか良い");
                    break;
                case 10 :
                    $("#how_is_this_product").text("とても良い");
                    break;
                default :
                    $("#how_is_this_product").text("");
            }

            targets.each(function (i, ele) {
                var target_star_val = $(ele).data("star-value");
                if (this_star_val >= target_star_val) {
                    $(ele).addClass("blueStar");
                }
            });
        }
    });

    $(".bigStar").on("mouseleave", function() {
        if (!sendFlag) {
            clearHowIsThisProduct();
            resetUserInfoArea();
            clearStarClass();
            appendYellowStarClass();
        }
    });


    $(".bigStar").on("click", function() {
        if (!sendFlag) {
            var this_star_val = $(this).data("star-value");
            $("#fixed_star_rate").attr("value", this_star_val);
            fixedStarValue = this_star_val;

            clearHowIsThisProduct();
            resetUserInfoArea();
            clearStarClass();
            appendYellowStarClass();

            if ($("#input_area").css("display") == "none") {
                $("#input_area").slideDown("slow");
                $("#input_area").css("display", "block");
            }
        }
    });

    // ここからレビュー送信処理
    $("#review_post_form").submit(function(e) {
        e.preventDefault();
        e.stopPropagation();

        var formData = new FormData(this);
        var url      = $(this).attr('action');

        $.ajax({
            type:     'POST',
            url:      url,
            data:     formData,
            dataType: 'json',
            processData: false,
            contentType: false
        })
        .done(function(message){
            sendFlag = true;
            $("#title_field").empty();
            $("#title_field").append('<span class="a-size-large a-color-success a-text-bold">レビューをお書きいただきありがとうございました。商品名：' + message.name + '</span><br><a href="/products/' + message.id + '" style="cursor: pointer">戻ってレビューを確認しましょう。</a>');
            $("#input_area").remove();
            $("#user_info_area").remove();
            $("#post_review_button").attr('disabled',false);
        })
        .fail(function(){
            alert('review post error');
            $("#post_review_button").attr('disabled',false);
        })
    });
});
