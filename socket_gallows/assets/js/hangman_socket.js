import { Socket } from "phoenix"
export default class HangmanSocket {
  constructor(tally) {
    this.tally = tally
    this.socket = new Socket("/socket", {})
    this.socket.connect()
  }

  connectToHangman() {
    this.setupChannel()
    this.channel
      .join()
      .receive("ok", resp => {
        console.log("Joined successfully", resp)
        this.fetchTally()
      })
      .receive("error", resp => {
        alert("Unable to join", resp)
        throw (resp)
      })
  }

  setupChannel() {
    this.channel = this.socket.channel("hangman:game", {})
    this.channel.on("tally", (tally) => {
      this.copy_tally(tally)
    })
  }

  fetchTally() {
    this.channel.push("tally", {})
  }

  make_move(guess) {
    this.channel.push("make_move", guess)
  }

  new_game() {
    this.channel.push("new_game", {})
  }

  copy_tally(from) {
    for (let k in from) {
      this.tally[k] = from[k]
    }
  }
}
