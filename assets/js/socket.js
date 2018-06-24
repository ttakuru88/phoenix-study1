// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/web/endpoint.ex":
import {Socket} from "phoenix"
import Vue from 'vue/dist/vue.js';

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

// Now that you are connected, you can join channels with a topic:
const channel = socket.channel("chat_room:main", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

const messages = new Vue({
  el: '#messages',
  data: {
    messages: []
  }
})

const newMessageEl = document.getElementById('new-message')
const submitButtonEl = document.getElementById('send-message')

submitButtonEl.addEventListener('click', () => {
  const message = newMessageEl.value
  if(message.length <= 0) {
    return
  }

  channel.push('speak', {message: message})
  newMessageEl.value = ''
}, false)

channel.on('speak', payload => {
  messages.messages.unshift({text: payload.message})
})

export default socket
