import "dart:io";
import "package:nyxx/nyxx.dart";
import "Option_Bot.dart";

// Main function
void main() {
  //Input Token
  Options botSettings = Options();

  // Create new bot instance
  final bot = NyxxFactory.createNyxxWebsocket(
      botSettings.token, GatewayIntents.allUnprivileged)
    ..registerPlugin(Logging()) // Default logging plugin
    ..registerPlugin(
        CliIntegration()) // Cli integration for nyxx allows stopping application via SIGTERM and SIGKILl
    ..registerPlugin(
        IgnoreExceptions()) // Plugin that handles uncaught exceptions that may occur
    ..connect();

  // Listen to ready event. Invoked when bot is connected to all shards. Note that cache can be empty or not incomplete.
  bot.eventsWs.onReady.listen((e) {
    print("봇이 준비됬어요!");
  });

  // Listen to all incoming messages
  bot.eventsWs.onMessageReceived.listen((e) {
    // Checking that bot is working
    if (e.message.content == botSettings.commandPrefix + "ping") {
      e.message.channel.sendMessage(MessageBuilder.content("연결 테스트!"));
    }
    // Exit bot
    if (e.message.content == botSettings.commandPrefix + "disconnect") {
      exit(0);
    }
    //introduce command
    if (e.message.content == botSettings.commandPrefix + "help") {
      e.message.channel.sendMessage(MessageBuilder.content("커멘드 목록\n" +
          botSettings.commandPrefix +
          "ping, " +
          botSettings.commandPrefix +
          "disconnect"));
    }
  });
}
