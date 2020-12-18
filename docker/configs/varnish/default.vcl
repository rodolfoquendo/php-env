vcl 4.0;


backend default {
  .host = "proxy";
  .port = "8080";
  .connect_timeout = 1000s;
  .first_byte_timeout = 1000s;
  .between_bytes_timeout = 1000s;
  # Probing configuration
  .probe = {
    .request =
      "HEAD /ping.php HTTP/1.1"
      "Host: proxy:8080"
      "Connection: close";
    .interval  = 60s; # probe backend every hour
    .timeout   = 15s;
    .window    = 40;
    .threshold = 38;
    .initial   = 38;
  }
}