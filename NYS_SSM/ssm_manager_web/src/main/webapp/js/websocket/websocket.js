$(function(){
    refresh();
});


function refresh(){
    $.ajax({
        type:'POST',
        url:getPath()+'/conversation/getConversationList',
        success:function(data){
            if (data.status == 1){
                var list = data.data;
                for (var i=0 ;i<list.length ;i++){
                    var conversation = list[i];
                    var msg = conversation.content;
                    $("#msg").append(msg+"<br/>")
                }
            } else {

            }
        }
    });
}