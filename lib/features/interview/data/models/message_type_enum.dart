enum MessageType {
  sended,
  recieved;

  MessageType fromString(final String json) {
    if (json == "sended") {
      return MessageType.sended;
    } else if (json == "recieved") {
      return MessageType.recieved;
    } else {
      throw Exception("Error Type");
    }
  }
}
