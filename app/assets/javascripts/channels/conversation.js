var currentUrl = new URL(document.location)

App.conversation = App.cable.subscriptions.create({ channel: "ConversationChannel", conversation_id: currentUrl.pathname.split('/')[2] }, {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    let $t0 = performance.now();
    toastr.info(data['notification'])

    var conversation = $('#conversations-list').find("[data-conversation-id='" + data['conversation_id'] + "']");
    conversation.find('.messages-list').find('ul').append(data['message']);

    var messages_list = conversation.find('.messages-list');
    var height = messages_list[0].scrollHeight;
    messages_list.scrollTop(height);

    let $t1 = performance.now();
    toastr.info(`MessageBroadcastWorker JID-${data['jid']} INFO: done`)
  },
  speak: function(message) {
    return this.perform('speak', {
      message: message,
      conversation_id: message[0].value
    });
  }
});

$(document).on('submit', '.new_message', function(e) {
  e.preventDefault();
  var values = $(this).serializeArray();
  App.conversation.speak(values);
  $(this).trigger('reset');
});
