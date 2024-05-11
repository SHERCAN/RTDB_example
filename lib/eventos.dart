import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
// Import the necessary packages
import 'dart:async';
// Example stream data from a server RTDB Firebase
Future eventosServidor() async {
  // Create an HTTP client
  var client = http.Client();
  // Define the URL of the server
  const url = "https://shercanga-ba1fa-default-rtdb.firebaseio.com/.json";

  // Define the headers for stream data
  final headers = {
    'Accept': 'text/event-stream',
  };
  developer.log("Inicio eventos", name: "eventos");
  // Body in this case is empty
  String body = "";
  // Create a request object
  var request = http.Request('GET', Uri.parse(url));
  request.body = body;
  request.headers.addAll(headers);
  // Send the request and get the response
  final http.StreamedResponse response = await client.send(request);
// Listen for data events from the server
  response.stream.listen((List<int> value) {
    // Convert the data to a string
    var str = utf8.decode(value);
    // In this case keep-live not event data
    if (!str.contains("null")) {
      // Splice the string to get only the data
      String data = str.split("data: ")[1];
      // Convert the data to JSON
      Map<String, dynamic> jsonData = jsonDecode(data);
      developer.log(jsonData["data"].toString(), name: "eventos-data");
    } else {
      // In this case keep-live event data
      developer.log("null", name: "eventos");
    }
  });
}
