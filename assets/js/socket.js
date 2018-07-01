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

const chat = new Vue({
  el: '#chat',
  data: {
    messages: [],
    newMessage: ''
  },
  methods: {
    sendMessage: () => {
      channel.push('speak', {message: chat.newMessage})
      chat.newMessage = ''
    }
  }
})

channel.on('speak', payload => {
  chat.messages.unshift({text: payload.message})
})

export default socket
