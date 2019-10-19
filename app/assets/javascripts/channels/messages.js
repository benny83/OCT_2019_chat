// App.messages = App.cable.subscriptions.create('ConversationChannel', {  
//   received: function(data) {
//     alert('123123')
//     $("#messages").removeClass('hidden')
//     return $("[data-chatroom='" + data.chatroom_id + "']").append(data.message);
//   },

//   speak: function(message) {
//     return this.perform('speak', {
//       message: message
//     });
//   }
// });

// $(document).on('submit', '.new_message', function(e) {
//   e.preventDefault();
//   var values = $(this).serializeArray();
//   // App.messages.speak(values);
//   debugger;
//   App.messages.send({});
//   $(this).trigger('reset');
// });



// // $(document).on('turbolinks:load', function() {
// //   submitNewMessage();
// // });

// // function submitNewMessage(){
// //   $('textarea#message_content').keydown(function(event) {
// //     if (event.keyCode == 13) {
// //         var msg = event.target.value
// //         var chatroomId = $("[data-chatroom]").data().chatroom
// //         App.messages.send({message: msg, chatroom_id: chatroomId})
// //         $('[data-textarea="message"]').val(" ")
// //         return false;
// //      }
// //   });
// // }